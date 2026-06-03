# Installation

Install skills by cloning the repository and copying skill folders into the directory your agent reads.

The commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

## Install All Skills

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/* ~/.agents/skills/
```

Pinned version:

```bash
git clone --branch v0.3.3 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/* ~/.agents/skills/
```

## Install One Skill

Architecture review:

```bash
git clone --branch v0.3.3 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/engineering-architecture-review ~/.agents/skills/
```

Engineering delivery:

```bash
git clone --branch v0.3.3 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/engineering-delivery ~/.agents/skills/
```

## Zed

Use clone-based installation into the skills directory used by your Zed setup. Example:

```text
~/.agents/skills
```

Zed can import a single `SKILL.md` from a raw URL, but that does not include supporting docs, templates, or examples. Clone-based installation is recommended.

Raw URLs:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture-review/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
```

## Claude Code

Install into the skills directory used by your Claude Code setup. Example:

```bash
git clone --branch v0.3.3 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.claude/skills
cp -R 0x12th-playbooks/skills/* ~/.claude/skills/
```

If Claude Code does not auto-load a skill, reference its `SKILL.md` from `CLAUDE.md`, project instructions, or from the prompt.

## Codex

Install into the skills directory used by your Codex setup. Example:

```bash
git clone --branch v0.3.3 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.codex/skills
cp -R 0x12th-playbooks/skills/* ~/.codex/skills/
```

Project-local installation:

```bash
mkdir -p .agents/skills
cp -R 0x12th-playbooks/skills/* .agents/skills/
```
