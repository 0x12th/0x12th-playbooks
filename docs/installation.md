# Installation

Install skills by cloning the repository and syncing skill folders into the directory your agent reads.

The current `master` installer targets existing agent homes: `~/.agents/skills`, `~/.claude/skills`, `~/.codex/skills`, and the active Hermes home's `skills/`. Hermes home is `$HERMES_HOME` when nonempty, otherwise `~/.hermes`. Missing homes are skipped; if none exist, only `~/.agents/skills` is created for first-time setup. Other Hermes profiles are never scanned or updated.

The installer treats `engineering-architecture`, `engineering-code-review`, `engineering-delivery`, and `product-evolution` as managed copies. Updating removes stale files inside those four folders but leaves every neighboring skill untouched. Keep custom variants in a fork or a separate project-local skill.

## Update Safety (Current Master)

All selected destinations are checked before any destination is modified. Symlink skills roots and managed skill destinations, non-directory destinations, source/destination identity (including physical aliases), source/target containment, and overlapping destination roots are rejected. Exact physical duplicates are installed once. Choose a skills root, not an individual skill folder or `/`. Paths containing newlines are unsupported and rejected.

The complete bundle is copied into fresh staging directories on each destination filesystem before publication starts. `rsync` is used when available; otherwise each tar archive must finish successfully before extraction into staging. Existing managed folders are renamed into backups, not deleted in advance; the skills root and neighboring skills are never replaced.

The rollback boundary is the **entire invocation**, including all default homes. A copy/archive failure leaves every previous bundle unchanged. A publication failure or handled `INT`/`TERM` restores the previous managed folders (including previous absence) in every selected home. `Installed` is printed only after all homes have published successfully. If rollback itself fails, the installer exits nonzero and reports the `.0x12th-playbooks.*` recovery directory containing remaining backups; preserve it and recover manually before retrying.

This is failure recovery, not an atomic multi-directory switch: readers can observe intermediate renames. Stop agents while updating, and do not run concurrent installers or other writers against these directories. Power loss, `SIGKILL`, filesystem failure, and concurrent path changes are not crash-safe or concurrency-safe. An unsuccessful first install can leave empty destination/parent directories. Staging and backups require additional disk space.

These safeguards and Hermes defaults apply from `v0.15.0` onward and to the current `master` installer, **not** to the historical `v0.14.0` installer. The pinned commands below install `v0.17.0` with its matching installer.

## Review Ownership Split

`v0.14.0` moves concrete code-review ownership from `engineering-delivery` to `engineering-code-review`.

These mixed states are unsupported:

1. New `engineering-code-review` with an older review-owning `engineering-delivery`.
2. New review-free `engineering-delivery` without `engineering-code-review`.

Install the complete `v0.17.0` bundle. If installing selected skills, keep those two folders on the same revision.

An unrelated neighboring skill named exactly `code-review` can overlap automatic selection. The installer warns about that folder but does not delete or rewrite it. After identifying its origin, remove it or make it manual-only where the runtime supports that option. The repository installer never modifies `~/.agents/skills/code-review` unless that exact directory is itself chosen as an explicit installation target, which is not a supported bundle target.

The manual commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

## Quick Install

Latest:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh
```

Pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/v0.17.0/install.sh | sh -s -- ~/.agents/skills v0.17.0
```

Custom target directory:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh -s -- ~/.claude/skills
```

Local clone:

```bash
./install.sh ~/.agents/skills
```

The first argument overrides `SKILLS_DIR`; the second overrides `PLAYBOOKS_REF` (default `master`). A local clone installs its own checked-out `skills/`, so check out the desired revision there. Piped execution fetches `REPO_URL` (this repository by default) at the requested ref and never trusts a current-directory `skills/` decoy.

## Install All Skills From A Clone

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

Pinned version:

```bash
git clone --branch v0.17.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

## Install Selected Skills

The review ownership split requires `engineering-code-review` and `engineering-delivery` from the same revision. The following historical manual commands install the pinned pair, but are **not transactional**: inspect destinations for symlinks, back up the old pair, stop readers, and restore both if either command fails. Prefer the current full-bundle installer for automatic preflight and rollback.

```bash
git clone --branch v0.17.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-code-review/ ~/.agents/skills/engineering-code-review/
rsync -a --delete 0x12th-playbooks/skills/engineering-delivery/ ~/.agents/skills/engineering-delivery/
```

`engineering-architecture` and `product-evolution` remain independently installable from latest or `v0.17.0`.

## Hermes Agent

To update only the intended Hermes home, select it explicitly:

```bash
./install.sh "${HERMES_HOME:-$HOME/.hermes}/skills"
```

An explicit destination can be created even if the home is missing; default discovery does not create missing Hermes homes. The installer does not read Hermes' sticky profile selection or change configuration. Run with the intended `HERMES_HOME` or pass its skills path explicitly; do not assume a shell outside Hermes knows the active profile.

According to the official [Skills System documentation](https://hermes-agent.nousresearch.com/docs/user-guide/features/skills#external-skill-directories), a profile-local skill in `$HERMES_HOME/skills` takes precedence over the same name in configured `skills.external_dirs` (for example `~/.agents/skills`). Trusted project-local skills have still higher precedence: project → profile-local → external. [Profiles](https://hermes-agent.nousresearch.com/docs/user-guide/profiles) have separate Hermes homes.

Prefer **one authoritative source** for this bundle per Hermes setup: either an installed profile-local copy, or a shared external directory. Updating an external copy cannot displace a stale profile-local duplicate. This installer does not search for or automatically remove duplicates, including categorized/nested copies or copies in other profiles; default installation into multiple existing agent homes can intentionally create multiple copies. For migration, identify the loaded origin, back up customizations, choose one source, and manually remove only the obsolete copies or external-directory configuration. Never delete another profile's skills as an automatic migration step.

## Zed

Use clone-based installation into the skills directory used by your Zed setup. Example:

```text
~/.agents/skills
```

Zed can import a single `SKILL.md` from a raw URL, but that does not include supporting references, templates, or examples. The `engineering-code-review` core preserves snapshot, worktree, trust, coverage, verdict, and read-only external-action boundaries, but clone-based installation remains recommended for provider/style details and examples.

Raw URLs:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-code-review/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/product-evolution/SKILL.md
```

## Claude Code

Install into the skills directory used by your Claude Code setup. Example:

```bash
git clone --branch v0.17.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.claude/skills
```

If Claude Code does not auto-load a skill, reference its `SKILL.md` from `CLAUDE.md`, project instructions, or the prompt.

## Codex

Install into the skills directory used by your Codex setup. Example:

```bash
git clone --branch v0.17.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.codex/skills
```

Project-local installation:

```bash
mkdir -p .agents/skills
./0x12th-playbooks/install.sh .agents/skills
```
