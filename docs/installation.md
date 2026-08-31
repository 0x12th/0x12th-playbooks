# Installation

Install skills by cloning the repository and syncing skill folders into the directory your agent reads.

By default, `install.sh` installs into existing agent homes: `~/.agents/skills`, `~/.claude/skills`, and `~/.codex/skills`. It skips missing agent homes so it does not create unused directories. If none exist, it falls back to `~/.agents/skills` for first-time setup.

The installer treats `engineering-architecture`, `engineering-code-review`, `engineering-delivery`, and `product-evolution` as managed copies. Updating removes stale files inside those four folders but leaves every neighboring skill untouched. Keep custom variants in a fork or a separate project-local skill.

## Upgrade to v0.14.0

`v0.14.0` is a coordinated bundle upgrade: concrete code-review ownership moved from `engineering-delivery` to `engineering-code-review`.

These mixed states are unsupported:

1. New `engineering-code-review` with an older review-owning `engineering-delivery`.
2. New review-free `engineering-delivery` without `engineering-code-review`.

Upgrade the complete bundle when possible. If installing individual skills, keep those two folders on the same release.

An unrelated neighboring skill named exactly `code-review` can overlap automatic selection. The installer warns about that folder but does not delete or rewrite it. After identifying its origin, remove it or make it manual-only where the runtime supports that option. The repository installer never modifies `~/.agents/skills/code-review` unless that exact directory is itself chosen as an explicit installation target, which is not a supported bundle target.

The manual commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

## Quick Install

Latest:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh
```

Pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/v0.14.0/install.sh | sh -s -- ~/.agents/skills v0.14.0
```

Custom target directory:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh -s -- ~/.claude/skills
```

Local clone:

```bash
./install.sh ~/.agents/skills
```

## Install All Skills From A Clone

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

Pinned version:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

## Install One Skill

The complete bundle is recommended. For one-skill workflows, keep `engineering-code-review` and `engineering-delivery` synchronized to the same release.

Architecture review:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-architecture/ ~/.agents/skills/engineering-architecture/
```

Engineering code review:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-code-review/ ~/.agents/skills/engineering-code-review/
```

Engineering delivery:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-delivery/ ~/.agents/skills/engineering-delivery/
```

Product evolution:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/product-evolution/ ~/.agents/skills/product-evolution/
```

## Zed

Use clone-based installation into the skills directory used by your Zed setup. Example:

```text
~/.agents/skills
```

Zed can import a single `SKILL.md` from a raw URL, but that does not include supporting references, templates, or examples. The `engineering-code-review` core preserves snapshot, worktree, trust, coverage, verdict, and provider-action safety for this raw-import case, but clone-based installation remains recommended for provider/style details and examples.

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
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.claude/skills
```

If Claude Code does not auto-load a skill, reference its `SKILL.md` from `CLAUDE.md`, project instructions, or the prompt.

## Codex

Install into the skills directory used by your Codex setup. Example:

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.codex/skills
```

Project-local installation:

```bash
mkdir -p .agents/skills
./0x12th-playbooks/install.sh .agents/skills
```
