# Installation

Install skills by cloning the repository and syncing skill folders into the directory your agent reads.

By default, `install.sh` installs into existing agent homes: `~/.agents/skills`, `~/.claude/skills`, and `~/.codex/skills`. It skips missing agent homes so it does not create unused directories. If none exist, it falls back to `~/.agents/skills` for first-time setup.

The installer treats `engineering-architecture`, `engineering-delivery`, and `product-evolution` as managed copies. Updating removes stale files inside those three folders but leaves every neighboring skill untouched. Keep custom variants in a fork or a separate project-local skill.

The manual commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

## Quick Install

Latest:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh
```

Pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/v0.13.0/install.sh | sh -s -- ~/.agents/skills v0.13.0
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
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

## Install One Skill

Architecture review:

```bash
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-architecture/ ~/.agents/skills/engineering-architecture/
```

Product evolution:

```bash
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/product-evolution/ ~/.agents/skills/product-evolution/
```

Engineering delivery:

```bash
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-delivery/ ~/.agents/skills/engineering-delivery/
```

## Zed

Use clone-based installation into the skills directory used by your Zed setup. Example:

```text
~/.agents/skills
```

Zed can import a single `SKILL.md` from a raw URL, but that does not include supporting references, templates, or examples. Clone-based installation is recommended.

Raw URLs:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/product-evolution/SKILL.md
```

## Claude Code

Install into the skills directory used by your Claude Code setup. Example:

```bash
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.claude/skills
```

If Claude Code does not auto-load a skill, reference its `SKILL.md` from `CLAUDE.md`, project instructions, or from the prompt.

## Codex

Install into the skills directory used by your Codex setup. Example:

```bash
git clone --branch v0.13.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.codex/skills
```

Project-local installation:

```bash
mkdir -p .agents/skills
./0x12th-playbooks/install.sh .agents/skills
```
