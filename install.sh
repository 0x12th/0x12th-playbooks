#!/bin/sh
set -eu

REPO_URL="${REPO_URL:-https://github.com/0x12th/0x12th-playbooks.git}"
TARGET_DIR="${1:-${SKILLS_DIR:-$HOME/.agents/skills}}"
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

  if command -v rsync >/dev/null 2>&1; then
    rsync -a "$src"/ "$dst"/
  else
    need tar
    (cd "$src" && tar cf - .) | (cd "$dst" && tar xf -)
  fi
}

cleanup_tmp=""
cleanup() {
  if [ -n "$cleanup_tmp" ] && [ -d "$cleanup_tmp" ]; then
    rm -rf "$cleanup_tmp"
  fi
}
trap cleanup EXIT INT TERM

SCRIPT_DIR="."
case "${0:-}" in
  */*) SCRIPT_DIR=${0%/*} ;;
esac

if [ -d "$SCRIPT_DIR/skills" ]; then
  SOURCE_DIR="$SCRIPT_DIR/skills"
elif [ -d "./skills" ]; then
  SOURCE_DIR="./skills"
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

copy_skills "$SOURCE_DIR" "$TARGET_DIR"

echo "Installed 0x12th-playbooks skills to $TARGET_DIR"
