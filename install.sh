#!/bin/sh
set -eu

REPO_URL="${REPO_URL:-https://github.com/0x12th/0x12th-playbooks.git}"
TARGET_DIR="${1:-${SKILLS_DIR:-}}"
REF="${2:-${PLAYBOOKS_REF:-master}}"

reject_newline() {
  case "$1" in
    *'
'*) echo "error: newline paths are not supported" >&2; exit 1 ;;
  esac
}
reject_newline "${TMPDIR:-/tmp}"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: required command not found: $1" >&2
    exit 1
  fi
}

warn_review_overlap() {
  target=$1
  if [ -d "$target/code-review" ]; then
    echo "warning: existing $target/code-review may overlap automatic selection with engineering-code-review; it was left unchanged" >&2
  fi
}

# Resolve even a not-yet-created directory without writing to it.
physical_path() (
  reject_newline "$1"
  case "$1" in
    /*) path=$1 ;;
    *) path=$PWD/$1 ;;
  esac
  while [ "$path" != / ] && [ "${path%/}" != "$path" ]; do path=${path%/}; done
  if [ -d "$path" ]; then
    # A sentinel preserves trailing newlines long enough to reject them.
    resolved=$(CDPATH= cd -- "$path" && pwd -P && printf '.') || return 1
    resolved=${resolved%?}
    resolved=${resolved%?}
    reject_newline "$resolved"
    printf '%s\n' "$resolved"
  elif [ -e "$path" ] || [ -L "$path" ]; then
    return 1
  else
    parent=$(physical_path "${path%/*}") || return 1
    case "${path##*/}" in
      .) printf '%s\n' "$parent" ;;
      # Traversal through a missing directory is invalid; retrying would recurse forever.
      ..) return 1 ;;
      *) printf '%s/%s\n' "${parent%/}" "${path##*/}" ;;
    esac
  fi
)

preflight_target() (
  path=$1
  while [ "$path" != / ] && [ "${path%/}" != "$path" ]; do path=${path%/}; done
  if [ -L "$path" ]; then
    echo "error: symlink target: $path" >&2
    exit 1
  fi
  target=$(physical_path "$path") || { echo "error: invalid target: $path" >&2; exit 1; }
  case "$target" in
    /|"$SOURCE_DIR"|"$SOURCE_DIR"/*|*/engineering-architecture|*/engineering-code-review|*/engineering-delivery|*/product-evolution|*/code-review)
      echo "error: unsafe target: $target" >&2; exit 1 ;;
  esac
  case "$SOURCE_DIR/" in
    "$target/"*) echo "error: target contains source: $target" >&2; exit 1 ;;
  esac
  if [ -f "$target/SKILL.md" ]; then
    echo "error: target is a skill, not a skills root: $target" >&2
    exit 1
  fi
  for skill_src in "$SOURCE_DIR"/*; do
    [ -f "$skill_src/SKILL.md" ] || continue
    skill_dst="$target/${skill_src##*/}"
    if [ -L "$skill_dst" ] || { [ -e "$skill_dst" ] && [ ! -d "$skill_dst" ]; }; then
      echo "error: unsafe skill target: $skill_dst" >&2
      exit 1
    fi
  done
  printf '%s\n' "$target"
)

copy_skills() {
  src="$1"
  dst="$2"
  archive="$3"
  # The caller owns staging; reject reuse instead of merging or deleting its contents.
  mkdir "$dst" || return 1

  found=0
  for skill_src in "$src"/*; do
    if [ ! -d "$skill_src" ] || [ ! -f "$skill_src/SKILL.md" ]; then
      continue
    fi

    found=1
    skill_name=${skill_src##*/}
    skill_dst="$dst/$skill_name"
    mkdir "$skill_dst" || return 1

    if command -v rsync >/dev/null 2>&1; then
      rsync -a --delete "$skill_src"/ "$skill_dst"/ || return 1
    else
      need tar
      # Do not pipe: POSIX sh would lose a failing archive producer's status.
      (cd "$skill_src" && tar cf "$archive" .) || return 1
      (cd "$skill_dst" && tar xf "$archive") || return 1
      rm "$archive" || return 1
    fi
  done

  if [ "$found" -eq 0 ]; then
    echo "error: no skill folders found in $src" >&2
    exit 1
  fi
}

cleanup_tmp=""
run_tmp=""
committed=0

rollback_target() (
  target=$1
  stage=$2
  failed=0
  for old in "$stage/old"/*; do
    [ -d "$old" ] || continue
    if rm -rf "$target/${old##*/}"; then
      mv "$old" "$target/${old##*/}" || failed=1
    else
      failed=1
    fi
  done
  for absent in "$stage/absent"/*; do
    [ -f "$absent" ] || continue
    rm -rf "$target/${absent##*/}" || failed=1
  done
  return "$failed"
)

# Store canonical targets once. Registration never writes to a destination.
register_target() {
  target=$(preflight_target "$1") || exit 1
  for entry in "$run_tmp"/*; do
    [ -f "$entry/target" ] || continue
    other=$(cat "$entry/target")
    [ "$target" != "$other" ] || return 0
    case "$target/" in
      "$other/"*) echo "error: overlapping targets: $target and $other" >&2; exit 1 ;;
    esac
    case "$other/" in
      "$target/"*) echo "error: overlapping targets: $target and $other" >&2; exit 1 ;;
    esac
  done
  entry="$run_tmp/$2"
  mkdir -p "$entry"
  printf '%s\n' "$target" > "$entry/target"
}

stage_target() {
  entry=$1
  target=$(cat "$entry/target")
  mkdir -p "$target"
  stage=$(mktemp -d "$target/.0x12th-playbooks.XXXXXX")
  printf '%s\n' "$stage" > "$entry/stage"
  copy_skills "$SOURCE_DIR" "$stage/new" "$stage/archive.tar" || { echo "error: staging failed for $target" >&2; exit 1; }
}

# Keep mutation phases in the parent shell so its INT/TERM traps remain active.
publish_target() {
  entry=$1
  target=$(cat "$entry/target")
  stage=$(cat "$entry/stage")
  mkdir -p "$stage/old" "$stage/absent" || exit 1
  for skill in "$stage/new"/*; do
    name=${skill##*/}
    if [ -d "$target/$name" ]; then
      mv "$target/$name" "$stage/old/$name" || { echo "error: backup failed: $target/$name" >&2; exit 1; }
    else
      : > "$stage/absent/$name" || exit 1
    fi
    mv "$skill" "$target/$name" || { echo "error: publication failed: $target/$name" >&2; exit 1; }
  done
}

cleanup() {
  status=$?
  trap - 0
  trap '' INT TERM
  retained=0
  if [ -n "$run_tmp" ]; then
    for entry in "$run_tmp"/*; do
      [ -f "$entry/stage" ] || continue
      stage=$(cat "$entry/stage") || { retained=1; status=1; continue; }
      target=$(cat "$entry/target") || { retained=1; status=1; continue; }
      if [ "$committed" -eq 1 ] || rollback_target "$target" "$stage"; then
        rm -rf "$stage" || status=1
      else
        echo "error: rollback incomplete; preserved recovery files at $stage" >&2
        retained=1
        status=1
      fi
    done
    if [ "$retained" -eq 0 ]; then rm -rf "$run_tmp" || status=1; fi
  fi
  if [ -n "$cleanup_tmp" ] && [ -d "$cleanup_tmp" ]; then
    rm -rf "$cleanup_tmp" || status=1
  fi
  exit "$status"
}
trap cleanup 0
trap 'exit 130' INT
trap 'exit 143' TERM

SOURCE_DIR=""
SCRIPT_DIR="."
case "${0:-}" in
  */install.sh) SCRIPT_DIR=${0%/*} ;;
  install.sh) ;;
  *) SCRIPT_DIR="" ;;
esac

if [ -n "$SCRIPT_DIR" ] && [ -f "$SCRIPT_DIR/install.sh" ] && [ -d "$SCRIPT_DIR/skills" ]; then
  SOURCE_DIR="$SCRIPT_DIR/skills"
else
  need git
  cleanup_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t 0x12th-playbooks)
  git clone --branch "$REF" --depth 1 "$REPO_URL" "$cleanup_tmp/repo"
  SOURCE_DIR="$cleanup_tmp/repo/skills"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "error: skills directory not found: $SOURCE_DIR" >&2
  exit 1
fi

SOURCE_DIR=$(physical_path "$SOURCE_DIR")

if [ -n "$TARGET_DIR" ]; then
  set -- "$TARGET_DIR"
else
  set --
  for agent_dir in "$HOME/.agents" "$HOME/.claude" "$HOME/.codex" "${HERMES_HOME:-$HOME/.hermes}"; do
    [ ! -d "$agent_dir" ] || set -- "$@" "$agent_dir/skills"
  done
  [ "$#" -ne 0 ] || set -- "$HOME/.agents/skills"
fi

# Register and preflight every destination before staging in any target.
run_tmp=$(mktemp -d 2>/dev/null || mktemp -d -t playbooks-transaction)
index=0
for target in "$@"; do
  index=$((index + 1))
  register_target "$target" "$index"
done

for entry in "$run_tmp"/*; do stage_target "$entry"; done
for entry in "$run_tmp"/*; do publish_target "$entry"; done
committed=1
for entry in "$run_tmp"/*; do
  target=$(cat "$entry/target")
  warn_review_overlap "$target"
  echo "Installed 0x12th-playbooks skills to $target"
done
