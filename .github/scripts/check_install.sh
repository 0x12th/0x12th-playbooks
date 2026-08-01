#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
TEST_ROOT=$(mktemp -d 2>/dev/null || mktemp -d -t playbooks-install-check)
trap 'rm -rf "$TEST_ROOT"' EXIT INT TERM

fail() {
  echo "error: $1" >&2
  exit 1
}

seed_stale_install() {
  target=$1
  mkdir -p "$target/unrelated-skill"
  : > "$target/unrelated-skill/keep"

  for skill in engineering-architecture engineering-delivery product-evolution; do
    mkdir -p "$target/$skill/docs"
    : > "$target/$skill/docs/legacy"
    : > "$target/$skill/stale-local-file"
  done
}

assert_authoritative_install() {
  target=$1

  for skill in engineering-architecture engineering-delivery product-evolution; do
    [ -f "$target/$skill/SKILL.md" ] || fail "$skill was not installed"
    [ -d "$target/$skill/references" ] || fail "$skill references were not installed"
    [ ! -e "$target/$skill/docs" ] || fail "$skill retained legacy docs"
    [ ! -e "$target/$skill/stale-local-file" ] || fail "$skill retained a stale file"
  done

  [ -f "$target/unrelated-skill/keep" ] || fail "an unrelated skill was modified"
}

explicit_target="$TEST_ROOT/explicit/skills"
seed_stale_install "$explicit_target"
"$ROOT/install.sh" "$explicit_target" >/dev/null
assert_authoritative_install "$explicit_target"

source_repo="$TEST_ROOT/source-repo"
mkdir -p "$source_repo"
cp -R "$ROOT/skills" "$source_repo/skills"
git -C "$source_repo" init -q
git -C "$source_repo" add skills
git -C "$source_repo" \
  -c user.name=playbooks-check \
  -c user.email=playbooks-check@example.invalid \
  commit -qm "test source"
git -C "$source_repo" tag test-ref

decoy_cwd="$TEST_ROOT/decoy-cwd"
decoy_target="$TEST_ROOT/decoy-target/skills"
mkdir -p "$decoy_cwd/skills/decoy"
: > "$decoy_cwd/skills/decoy/SKILL.md"
(
  cd "$decoy_cwd"
  REPO_URL="file://$source_repo" PLAYBOOKS_REF=test-ref \
    /bin/sh -s -- "$decoy_target" < "$ROOT/install.sh" >/dev/null
)
[ -f "$decoy_target/product-evolution/SKILL.md" ] || fail "piped install ignored the requested ref"
[ ! -e "$decoy_target/decoy" ] || fail "piped install trusted a decoy current-directory source"

default_home="$TEST_ROOT/default-home"
mkdir -p "$default_home/.agents" "$default_home/.codex"
HOME="$default_home" "$ROOT/install.sh" >/dev/null
[ -f "$default_home/.agents/skills/product-evolution/SKILL.md" ] || fail "default .agents target was not installed"
[ -f "$default_home/.codex/skills/product-evolution/SKILL.md" ] || fail "default .codex target was not installed"
[ ! -e "$default_home/.claude" ] || fail "missing .claude home was created"

fallback_home="$TEST_ROOT/fallback-home"
mkdir -p "$fallback_home"
HOME="$fallback_home" "$ROOT/install.sh" >/dev/null
[ -f "$fallback_home/.agents/skills/product-evolution/SKILL.md" ] || fail "fallback target was not installed"
[ ! -e "$fallback_home/.claude" ] || fail "fallback created .claude"
[ ! -e "$fallback_home/.codex" ] || fail "fallback created .codex"

fallback_bin="$TEST_ROOT/no-rsync-bin"
mkdir -p "$fallback_bin"
for command_name in mkdir tar rm; do
  ln -s "$(command -v "$command_name")" "$fallback_bin/$command_name"
done

tar_target="$TEST_ROOT/tar-fallback/skills"
seed_stale_install "$tar_target"
PATH="$fallback_bin" /bin/sh "$ROOT/install.sh" "$tar_target" >/dev/null
assert_authoritative_install "$tar_target"

echo "Installer checks passed."
