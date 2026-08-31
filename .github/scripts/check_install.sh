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
  mkdir -p "$target/unrelated-skill/nested" "$target/code-review/nested"
  printf '%s\n' 'preserve unrelated skill' > "$target/unrelated-skill/keep"
  printf '%s\n' 'preserve unrelated nested file' > "$target/unrelated-skill/nested/keep"
  printf '%s\n' 'preserve neighboring review skill' > "$target/code-review/SKILL.md"
  printf '%s\n' 'preserve neighboring review data' > "$target/code-review/nested/keep"

  for skill_dir in "$ROOT"/skills/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill=${skill_dir##*/}
    mkdir -p "$target/$skill/docs"
    : > "$target/$skill/docs/legacy"
    : > "$target/$skill/stale-local-file"
  done
}

assert_authoritative_install() {
  target=$1

  for skill_dir in "$ROOT"/skills/*; do
    [ -f "$skill_dir/SKILL.md" ] || continue
    skill=${skill_dir##*/}
    [ -f "$target/$skill/SKILL.md" ] || fail "$skill was not installed"
    [ -d "$target/$skill/references" ] || fail "$skill references were not installed"
    [ ! -e "$target/$skill/docs" ] || fail "$skill retained legacy docs"
    [ ! -e "$target/$skill/stale-local-file" ] || fail "$skill retained a stale file"
  done

  [ "$(cat "$target/unrelated-skill/keep")" = "preserve unrelated skill" ] || fail "an unrelated skill file was modified"
  [ "$(cat "$target/unrelated-skill/nested/keep")" = "preserve unrelated nested file" ] || fail "an unrelated skill tree was modified"
  [ "$(cat "$target/code-review/SKILL.md")" = "preserve neighboring review skill" ] || fail "the neighboring code-review skill was modified"
  [ "$(cat "$target/code-review/nested/keep")" = "preserve neighboring review data" ] || fail "the neighboring code-review tree was modified"
}

explicit_target="$TEST_ROOT/explicit/skills"
explicit_stderr="$TEST_ROOT/explicit.stderr"
seed_stale_install "$explicit_target"
"$ROOT/install.sh" "$explicit_target" >/dev/null 2>"$explicit_stderr"
assert_authoritative_install "$explicit_target"
grep -F "may overlap automatic selection with engineering-code-review; it was left unchanged" "$explicit_stderr" >/dev/null || fail "the neighboring code-review warning was not emitted"

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
[ -f "$decoy_target/engineering-code-review/SKILL.md" ] || fail "piped install ignored the requested ref"
[ ! -e "$decoy_target/decoy" ] || fail "piped install trusted a decoy current-directory source"

default_home="$TEST_ROOT/default-home"
mkdir -p "$default_home/.agents" "$default_home/.codex"
HOME="$default_home" "$ROOT/install.sh" >/dev/null
[ -f "$default_home/.agents/skills/engineering-code-review/SKILL.md" ] || fail "default .agents target was not installed"
[ -f "$default_home/.codex/skills/engineering-code-review/SKILL.md" ] || fail "default .codex target was not installed"
[ ! -e "$default_home/.claude" ] || fail "missing .claude home was created"

fallback_home="$TEST_ROOT/fallback-home"
mkdir -p "$fallback_home"
HOME="$fallback_home" "$ROOT/install.sh" >/dev/null
[ -f "$fallback_home/.agents/skills/engineering-code-review/SKILL.md" ] || fail "fallback target was not installed"
[ ! -e "$fallback_home/.claude" ] || fail "fallback created .claude"
[ ! -e "$fallback_home/.codex" ] || fail "fallback created .codex"

fallback_bin="$TEST_ROOT/no-rsync-bin"
mkdir -p "$fallback_bin"
for command_name in mkdir tar rm; do
  ln -s "$(command -v "$command_name")" "$fallback_bin/$command_name"
done

tar_target="$TEST_ROOT/tar-fallback/skills"
seed_stale_install "$tar_target"
PATH="$fallback_bin" /bin/sh "$ROOT/install.sh" "$tar_target" >/dev/null 2>/dev/null
assert_authoritative_install "$tar_target"

echo "Installer checks passed."
