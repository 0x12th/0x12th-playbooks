#!/bin/sh
set -eu

ROOT=$(CDPATH= cd -- "$(dirname -- "$0")/../.." && pwd)
TEST_ROOT=$(mktemp -d 2>/dev/null || mktemp -d -t playbooks-install-check)
trap 'rm -rf "$TEST_ROOT"' EXIT INT TERM
HOME="$TEST_ROOT/home"
HERMES_HOME="$HOME/.hermes"
TMPDIR="$TEST_ROOT/tmp"
export HOME HERMES_HOME TMPDIR
mkdir -p "$HOME" "$TMPDIR"

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

assert_rejected() {
  if "$@" >"$TEST_ROOT/rejected.stdout" 2>"$TEST_ROOT/rejected.stderr"; then
    fail "unsafe or failed installation returned success"
  fi
  if grep -F 'Installed ' "$TEST_ROOT/rejected.stdout" >/dev/null; then
    fail "failed installation announced success"
  fi
}

symlink_target="$TEST_ROOT/symlink/skills"
seed_stale_install "$symlink_target"
rm -rf "$symlink_target/engineering-architecture"
ln -s unrelated-skill "$symlink_target/engineering-architecture"
cp -R "$symlink_target" "$TEST_ROOT/symlink-before"
assert_rejected "$ROOT/install.sh" "$symlink_target"
diff -r "$TEST_ROOT/symlink-before/unrelated-skill" "$symlink_target/unrelated-skill" || fail "foreign symlink destination changed"
[ -L "$symlink_target/engineering-architecture" ] || fail "target symlink was replaced"

later_home="$TEST_ROOT/later-home"
seed_stale_install "$later_home/.agents/skills"
seed_stale_install "$later_home/.codex/skills"
rm -rf "$later_home/.codex/skills/engineering-delivery"
ln -s unrelated-skill "$later_home/.codex/skills/engineering-delivery"
cp -R "$later_home/.agents" "$TEST_ROOT/earlier-before"
assert_rejected env HOME="$later_home" "$ROOT/install.sh"
diff -r "$TEST_ROOT/earlier-before" "$later_home/.agents" || fail "unsafe later target changed earlier home"

self_repo="$TEST_ROOT/self-repo"
mkdir -p "$self_repo"
cp "$ROOT/install.sh" "$self_repo/install.sh"
cp -R "$ROOT/skills" "$self_repo/skills"
cp -R "$self_repo/skills" "$TEST_ROOT/self-before"
assert_rejected /bin/sh "$self_repo/install.sh" "$self_repo/skills"
diff -r "$TEST_ROOT/self-before" "$self_repo/skills" || fail "self-install changed source"
ln -s "$self_repo" "$TEST_ROOT/self-alias"
assert_rejected /bin/sh "$self_repo/install.sh" "$TEST_ROOT/self-alias/skills"
diff -r "$TEST_ROOT/self-before" "$self_repo/skills" || fail "physical self-install changed source"

unsafe_root="$TEST_ROOT/unsafe-root"
seed_stale_install "$unsafe_root/skills"
ln -s "$unsafe_root/skills" "$TEST_ROOT/root-link"
assert_rejected "$ROOT/install.sh" "$TEST_ROOT/root-link/"
assert_rejected "$ROOT/install.sh" "$unsafe_root/skills/engineering-delivery"
assert_rejected /bin/sh "$self_repo/install.sh" "$self_repo/skills/nested"
assert_rejected /bin/sh "$self_repo/install.sh" "$self_repo"

# Existing parent traversal works; traversal through a missing parent is rejected.
mkdir -p "$TEST_ROOT/path-parent"
# Bound the whole process group: the regression creates recursive child shells.
python3 - "$ROOT/install.sh" "$TEST_ROOT/missing-parent/../traversal-target" <<'PY'
import os
import signal
import subprocess
import sys

process = subprocess.Popen(sys.argv[1:], stdout=subprocess.PIPE,
                           stderr=subprocess.PIPE, start_new_session=True)
try:
    stdout, stderr = process.communicate(timeout=3)
except subprocess.TimeoutExpired:
    os.killpg(process.pid, signal.SIGKILL)
    process.communicate()
    raise SystemExit("error: invalid path resolution did not terminate")
if process.returncode == 0 or b"Installed " in stdout:
    raise SystemExit("error: invalid parent traversal was accepted")
PY
[ ! -e "$TEST_ROOT/missing-parent" ] && [ ! -e "$TEST_ROOT/traversal-target" ] || fail "invalid traversal created directories"
"$ROOT/install.sh" "$TEST_ROOT/path-parent/../valid-traversal/skills" >/dev/null
[ -f "$TEST_ROOT/valid-traversal/skills/engineering-delivery/SKILL.md" ] || fail "existing parent traversal was rejected"

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
git -C "$source_repo" branch -M master

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

# A requested master must not silently follow the remote's default branch.
git -C "$source_repo" checkout -qb alternate-default
: > "$source_repo/skills/engineering-delivery/default-branch-only"
git -C "$source_repo" add skills
git -C "$source_repo" -c user.name=playbooks-check \
  -c user.email=playbooks-check@example.invalid commit -qm "different default branch"
master_target="$TEST_ROOT/master target/skills"
REPO_URL="file://$source_repo" PLAYBOOKS_REF=master \
  /bin/sh -s -- "$master_target" < "$ROOT/install.sh" >/dev/null
[ -f "$master_target/engineering-delivery/SKILL.md" ] || fail "master was not installed"
[ ! -e "$master_target/engineering-delivery/default-branch-only" ] || fail "master installation followed the remote default branch"

missing_ref_target="$TEST_ROOT/missing-ref/skills"
seed_stale_install "$missing_ref_target"
cp -R "$missing_ref_target" "$TEST_ROOT/missing-ref-before"
assert_rejected env REPO_URL="file://$source_repo" PLAYBOOKS_REF=missing-ref \
  /bin/sh -s -- "$missing_ref_target" < "$ROOT/install.sh"
diff -r "$TEST_ROOT/missing-ref-before" "$missing_ref_target" || fail "missing ref changed installation"

default_home="$TEST_ROOT/default-home"
mkdir -p "$default_home/.agents" "$default_home/.codex" "$default_home/.hermes"
HOME="$default_home" HERMES_HOME= "$ROOT/install.sh" >/dev/null
[ -f "$default_home/.agents/skills/engineering-code-review/SKILL.md" ] || fail "default .agents target was not installed"
[ -f "$default_home/.codex/skills/engineering-code-review/SKILL.md" ] || fail "default .codex target was not installed"
[ ! -e "$default_home/.claude" ] || fail "missing .claude home was created"
[ -f "$default_home/.hermes/skills/engineering-code-review/SKILL.md" ] || fail "existing Hermes home was not installed"

active_home="$TEST_ROOT/active-home"
mkdir -p "$active_home/.hermes/profiles/active" "$active_home/.hermes/profiles/other"
HOME="$active_home" HERMES_HOME="$active_home/.hermes/profiles/active" "$ROOT/install.sh" >/dev/null
[ -f "$active_home/.hermes/profiles/active/skills/engineering-code-review/SKILL.md" ] || fail "active Hermes home was not installed"
[ ! -e "$active_home/.hermes/skills" ] || fail "inactive default Hermes home was changed"
[ ! -e "$active_home/.hermes/profiles/other/skills" ] || fail "another Hermes profile was changed"
[ ! -e "$active_home/.agents" ] || fail "Hermes-only installation created fallback home"

fallback_home="$TEST_ROOT/fallback-home"
mkdir -p "$fallback_home"
HOME="$fallback_home" "$ROOT/install.sh" >/dev/null
[ -f "$fallback_home/.agents/skills/engineering-code-review/SKILL.md" ] || fail "fallback target was not installed"
[ ! -e "$fallback_home/.claude" ] || fail "fallback created .claude"
[ ! -e "$fallback_home/.codex" ] || fail "fallback created .codex"
[ ! -e "$fallback_home/.hermes" ] || fail "fallback created .hermes"
[ ! -e "$HERMES_HOME" ] || fail "missing active Hermes home was created"

fallback_bin="$TEST_ROOT/no-rsync-bin"
mkdir -p "$fallback_bin"
for command_name in mkdir tar rm mktemp mv cat; do
  ln -s "$(command -v "$command_name")" "$fallback_bin/$command_name"
done

tar_target="$TEST_ROOT/tar-fallback/skills"
seed_stale_install "$tar_target"
PATH="$fallback_bin" /bin/sh "$ROOT/install.sh" "$tar_target" >/dev/null 2>/dev/null
assert_authoritative_install "$tar_target"

# Exercise the internal copy contract without running installer discovery.
copy_helper="$TEST_ROOT/copy-helper.sh"
python3 - "$ROOT/install.sh" "$copy_helper" <<'PY'
from pathlib import Path
import sys

source = Path(sys.argv[1]).read_text()
function = source[source.index("copy_skills() {"):source.index('\ncleanup_tmp=""')]
Path(sys.argv[2]).write_text('set -eu\nneed() { command -v "$1" >/dev/null 2>&1; }\n'
                           + function + '\ncopy_skills "$@"\n')
PY
for copy_path in "$PATH" "$fallback_bin"; do
  existing_copy="$TEST_ROOT/existing-copy"
  mkdir -p "$existing_copy"
  assert_rejected env PATH="$copy_path" /bin/sh "$copy_helper" \
    "$ROOT/skills" "$existing_copy" "$TEST_ROOT/copy-archive.tar"
  rmdir "$existing_copy" || fail "existing empty destination was modified"
done

# Technical archive names must not collide with source skill directory names.
archive_repo="$TEST_ROOT/archive-name-repo"
mkdir -p "$archive_repo/skills/archive.tar"
cp "$ROOT/install.sh" "$archive_repo/install.sh"
printf '%s\n' 'archive-name fixture' > "$archive_repo/skills/archive.tar/SKILL.md"
archive_target="$TEST_ROOT/archive-name-target"
PATH="$fallback_bin" /bin/sh "$archive_repo/install.sh" "$archive_target" >/dev/null
diff -r "$archive_repo/skills" "$archive_target" || fail "archive name collision changed the bundle"

copy_failure="$TEST_ROOT/copy-failure/skills"
seed_stale_install "$copy_failure"
cp -R "$copy_failure" "$TEST_ROOT/copy-before"
failure_bin="$TEST_ROOT/failure-bin"
mkdir -p "$failure_bin"
if REAL_RSYNC=$(command -v rsync); then
  export REAL_RSYNC
  printf '%s\n' '#!/bin/sh' '"$REAL_RSYNC" "$@" || exit $?' \
    'case "$*" in *engineering-delivery*) exit 73 ;; esac' > "$failure_bin/rsync"
  chmod +x "$failure_bin/rsync"
  assert_rejected env PATH="$failure_bin:$PATH" "$ROOT/install.sh" "$copy_failure"
  diff -r "$TEST_ROOT/copy-before" "$copy_failure" || fail "copy failure left a mixed bundle"
  rm "$failure_bin/rsync"
else
  echo "Skipping rsync-specific fault injection: rsync is not installed."
fi

archive_failure="$TEST_ROOT/archive-failure/skills"
seed_stale_install "$archive_failure"
cp -R "$archive_failure" "$TEST_ROOT/archive-before"
REAL_TAR=$(command -v tar)
export REAL_TAR
rm "$fallback_bin/tar"
printf '%s\n' '#!/bin/sh' '"$REAL_TAR" "$@" || exit $?' \
  'case "$1:$PWD" in c*:*/engineering-delivery) exit 74 ;; esac' > "$fallback_bin/tar"
chmod +x "$fallback_bin/tar"
assert_rejected env PATH="$fallback_bin" /bin/sh "$ROOT/install.sh" "$archive_failure"
diff -r "$TEST_ROOT/archive-before" "$archive_failure" || fail "archive failure changed installation"

publish_home="$TEST_ROOT/publish-home"
seed_stale_install "$publish_home/.agents/skills"
seed_stale_install "$publish_home/.codex/skills"
rm -rf "$publish_home/.agents/skills/engineering-code-review"
cp -R "$publish_home" "$TEST_ROOT/publish-before"
REAL_MV=$(command -v mv)
export REAL_MV
printf '%s\n' '#!/bin/sh' \
  'case "$1:$2" in */new/engineering-delivery:*/.codex/skills/engineering-delivery) exit 75 ;; esac' \
  'exec "$REAL_MV" "$@"' > "$failure_bin/mv"
chmod +x "$failure_bin/mv"
assert_rejected env HOME="$publish_home" PATH="$failure_bin:$PATH" "$ROOT/install.sh"
diff -r "$TEST_ROOT/publish-before" "$publish_home" || fail "publication failure did not restore all homes"

# Deliver a signal after a real publication rename, not before it.
printf '%s\n' '#!/bin/sh' '"$REAL_MV" "$@" || exit $?' \
  'case "$1:$2" in */new/engineering-delivery:*/.codex/skills/engineering-delivery) kill -s "$FAIL_SIGNAL" "$PPID" ;; esac' > "$failure_bin/mv"
for signal in INT TERM; do
  assert_rejected env HOME="$publish_home" PATH="$failure_bin:$PATH" FAIL_SIGNAL="$signal" "$ROOT/install.sh"
  diff -r "$TEST_ROOT/publish-before" "$publish_home" || fail "$signal did not roll back publication"
done

# A second I/O failure during rollback must retain the only old copy.
printf '%s\n' '#!/bin/sh' \
  'case "$1:$2" in */new/engineering-delivery:*/.codex/skills/engineering-delivery|*/old/engineering-delivery:*/.codex/skills/engineering-delivery) exit 76 ;; esac' \
  'exec "$REAL_MV" "$@"' > "$failure_bin/mv"
assert_rejected env HOME="$publish_home" PATH="$failure_bin:$PATH" "$ROOT/install.sh"
retained=0
for backup in "$publish_home/.codex/skills"/.0x12th-playbooks.*/old/engineering-delivery; do
  [ -d "$backup" ] || continue
  diff -r "$TEST_ROOT/publish-before/.codex/skills/engineering-delivery" "$backup" || fail "rollback lost backup contents"
  retained=1
done
[ "$retained" -eq 1 ] || fail "failed rollback deleted its backup"
grep -F 'preserved recovery files at ' "$TEST_ROOT/rejected.stderr" >/dev/null || fail "missing recovery path diagnostic"
rm "$failure_bin/mv"

duplicate_home="$TEST_ROOT/duplicate-home"
mkdir -p "$duplicate_home/.agents"
ln -s "$duplicate_home/.agents" "$duplicate_home/alias"
HOME="$duplicate_home" HERMES_HOME="$duplicate_home/alias" "$ROOT/install.sh" > "$TEST_ROOT/duplicate.stdout"
[ "$(grep -c 'Installed ' "$TEST_ROOT/duplicate.stdout")" -eq 1 ] || fail "physical duplicate target installed twice"

nested_home="$TEST_ROOT/nested-home"
seed_stale_install "$nested_home/.agents/skills"
mkdir -p "$nested_home/.agents/skills/engineering-delivery/profile"
cp -R "$nested_home" "$TEST_ROOT/nested-before"
assert_rejected env HOME="$nested_home" HERMES_HOME="$nested_home/.agents/skills/engineering-delivery/profile" "$ROOT/install.sh"
diff -r "$TEST_ROOT/nested-before" "$nested_home" || fail "overlapping targets changed installation"

newline_target="$TEST_ROOT/newline
"
assert_rejected "$ROOT/install.sh" "$newline_target"
[ ! -e "$newline_target" ] && [ ! -e "$TEST_ROOT/newline" ] || fail "newline path was normalized or created"

echo "Installer checks passed."
