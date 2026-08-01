#!/bin/sh
set -eu

REPO_URL="${REPO_URL:-https://github.com/0x12th/0x12th-playbooks.git}"
TARGET_DIR="${1:-${SKILLS_DIR:-}}"
REF="${2:-${PLAYBOOKS_REF:-master}}"

need() {
  if ! command -v "$1" >/dev/null 2>&1; then
    echo "error: required command not found: $1" >&2
    exit 1
  fi
}

copy_skills() {
  src="$1"
  dst="$2"
  mkdir -p "$dst"

  found=0
  for skill_src in "$src"/*; do
    if [ ! -d "$skill_src" ] || [ ! -f "$skill_src/SKILL.md" ]; then
      continue
    fi

    found=1
    skill_name=${skill_src##*/}
    skill_dst="$dst/$skill_name"

    if command -v rsync >/dev/null 2>&1; then
      mkdir -p "$skill_dst"
      rsync -a --delete "$skill_src"/ "$skill_dst"/
    else
      need tar
      rm -rf "$skill_dst"
      mkdir -p "$skill_dst"
      (cd "$skill_src" && tar cf - .) | (cd "$skill_dst" && tar xf -)
    fi
  done

  if [ "$found" -eq 0 ]; then
    echo "error: no skill folders found in $src" >&2
    exit 1
  fi
}

install_default_targets() {
  installed=0

  for agent_dir in "$HOME/.agents" "$HOME/.claude" "$HOME/.codex"; do
    if [ -d "$agent_dir" ]; then
      copy_skills "$SOURCE_DIR" "$agent_dir/skills"
      echo "Installed 0x12th-playbooks skills to $agent_dir/skills"
      installed=1
    fi
  done

  if [ "$installed" -eq 0 ]; then
    fallback="$HOME/.agents/skills"
    copy_skills "$SOURCE_DIR" "$fallback"
    echo "Installed 0x12th-playbooks skills to $fallback"
  fi
}

cleanup_tmp=""
cleanup() {
  if [ -n "$cleanup_tmp" ] && [ -d "$cleanup_tmp" ]; then
    rm -rf "$cleanup_tmp"
  fi
}
trap cleanup EXIT INT TERM

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
  if [ "$REF" = "master" ]; then
    git clone --depth 1 "$REPO_URL" "$cleanup_tmp/repo"
  else
    git clone --branch "$REF" --depth 1 "$REPO_URL" "$cleanup_tmp/repo"
  fi
  SOURCE_DIR="$cleanup_tmp/repo/skills"
fi

if [ ! -d "$SOURCE_DIR" ]; then
  echo "error: skills directory not found: $SOURCE_DIR" >&2
  exit 1
fi

if [ -n "$TARGET_DIR" ]; then
  copy_skills "$SOURCE_DIR" "$TARGET_DIR"
  echo "Installed 0x12th-playbooks skills to $TARGET_DIR"
else
  install_default_targets
fi
