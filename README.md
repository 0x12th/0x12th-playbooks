# 0x12th-playbooks

`0x12th-playbooks` is a collection of practical engineering playbooks and agent skills for architecture, delivery, migration planning, technical decision-making, and software evolution.

It is not a prompt collection. It is a structured library of reusable skills for AI coding agents that need to review real systems, make technical decisions, implement changes safely, and avoid unnecessary architecture work.

AI coding agents are useful when they stay inside the right scope. They become risky when every local change turns into a broad architecture audit, or every architecture question turns into premature implementation.

This repository separates two common engineering intents:

- **Architecture review:** deciding how the system should be designed or evolved.
- **Engineering delivery:** implementing bounded changes safely.

The skills are designed to reduce context consumption, prioritize selected context, apply clear stop conditions, and avoid over-engineered recommendations.

## Skills

| Skill | Answers | Use when |
|---|---|---|
| `engineering-architecture-review` | How should the system evolve safely? | Architecture review, system design, architecture decisions, migration planning, service boundaries, domain/data ownership, architecture debt, reliability strategy, observability architecture, deployment architecture, design challenge, decision support |
| `engineering-delivery` | How should this change be implemented safely? | Implementation, bug fixes, tests, CI fixes, code review, diff review, patch review, commit review, PR review, local refactoring, validation, PR preparation, incremental improvements |

Use `engineering-architecture-review` when the question is about design, tradeoffs, service boundaries, ownership, migrations, deployment architecture, reliability strategy, or whether a proposed change should exist.

Use `engineering-delivery` when the request is to implement, fix, test, validate, review code, review a diff, review a patch, review a commit, review a PR, refactor locally, prepare a PR, or make the next approved incremental change.

Use `engineering-architecture-review` before `engineering-delivery` when a coding task requires a design or migration decision first.

## Installation

Install the full skill folders when possible, not only `SKILL.md`. The supporting `docs/`, `templates/`, and `examples/` are intentionally loaded on demand and improve behavior after the skill is selected.

The commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

### Install All Skills

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/* ~/.agents/skills/
```

Pinned version:

```bash
git clone --branch v0.4.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/* ~/.agents/skills/
```

### Install One Skill

Architecture review:

```bash
git clone --branch v0.4.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/engineering-architecture-review ~/.agents/skills/
```

Engineering delivery:

```bash
git clone --branch v0.4.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
cp -R 0x12th-playbooks/skills/engineering-delivery ~/.agents/skills/
```

### Agent Paths

Common destinations:

- Zed: `~/.agents/skills`
- Claude Code: `~/.claude/skills`
- Codex: `~/.codex/skills`
- Project-local skills: `.agents/skills`

Raw `SKILL.md` URLs are useful for agents that support URL imports, but they do not include supporting docs, templates, or examples:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture-review/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
```

See `docs/installation.md` for more installation details.

## Automatic Selection

Most AI coding agents select skills primarily from the skill `name` and frontmatter `description` in each `SKILL.md`. The descriptions in this repository expose common trigger phrases such as architecture review, migration planning, service boundaries, implementation, bug fixes, tests, CI fixes, code review, diff review, and PR review.

`manifests/skills.json` is an index and documentation aid. Some agents may use it, but it is not an official cross-agent standard and should not be required for skill loading.

For project-level agent instructions, see `docs/agent-bootstrap.md`. Use it in `AGENTS.md`, `CLAUDE.md`, or similar files when an agent does not reliably discover installed skills by itself.

## Usage

Architecture review:

```text
Run a quick architecture scan of this repository. Return only the top 5 findings.
```

```text
Challenge this proposal: split one shared backend into separate deployables for three business capabilities.
Focus on operational cost, migration risk, ownership, and long-term maintenance.
```

```text
Should background jobs move to a different queue runtime?
```

Engineering delivery:

```text
Use engineering-delivery.

Fix the failing CI test and run the relevant validation.
```

```text
Use engineering-delivery.

Implement the first approved migration step without changing public behavior.
```

```text
Write tests for the selected code.
```

```text
Use engineering-delivery.

Review this PR for bugs, regressions, and missing tests.
```

## Optional Memory Backends

`0x12th-playbooks` works without any memory system.

The skills are designed to operate from selected context, repository files, code, tests, logs, diffs, and user-provided information.

When an optional memory backend is available through the agent runtime, it may be used as supplemental context for previous architecture decisions, migration history, ADRs, design notes, incident investigations, project conventions, and unresolved follow-ups.

Memory must not replace current repository evidence. Current code, configuration, tests, logs, validation results, and selected context always take precedence over remembered information.

One supported optional approach is [GBrain](https://github.com/garrytan/gbrain). GBrain can provide project memory, historical context, notes, and cross-session knowledge for compatible agents through MCP or another runtime integration.

GBrain is optional and is not required for any skill in this repository. This repository does not install, configure, or require GBrain. Agents should use it only when it is already available through their runtime.

If unavailable, all skills continue to operate normally. See `docs/optional-context-sources.md` for the trust and usage rules.

## Design Principles

These skills use:

- Context minimization
- Instruction loading on demand
- Clear skill boundaries
- Intent detection
- Selected-context priority
- Explicit exploration budgets
- Stop conditions
- Confidence gates
- Communication discipline
- Decision before implementation
- Evidence-first reasoning

See:

- `docs/installation.md`
- `docs/agent-bootstrap.md`
- `docs/skill-selection.md`
- `docs/repository-structure.md`
- `docs/authoring-guidelines.md`
- `manifests/skills.json`

## Repository Structure

```text
0x12th-playbooks/
├── skills/
│   ├── engineering-architecture-review/
│   └── engineering-delivery/
├── docs/
├── manifests/
└── CHANGELOG.md
```

## Development And Contribution

Keep skill entrypoints short, move detailed behavior into directly linked docs, and avoid adding new files unless they improve agent behavior. See `docs/authoring-guidelines.md`.
