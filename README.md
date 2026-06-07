# 0x12th-playbooks

`0x12th-playbooks` is a collection of practical playbooks and agent skills for product decisions, architecture, delivery, migration planning, technical decision-making, and software evolution.

It is not a prompt collection. It is a structured library of reusable skills for AI coding agents that need to review real systems, make technical decisions, implement changes safely, and avoid unnecessary architecture work.

AI coding agents are useful when they stay inside the right scope. They become risky when every local change turns into a broad architecture audit, or every architecture question turns into premature implementation.

This repository separates three common intents:

- **Product evolution:** deciding whether, why, when, and in what scope to invest.
- **Architecture review:** deciding how the system should be designed, migrated, or evolved technically.
- **Engineering delivery:** diagnosing, reviewing, validating, and explicitly requested implementation.

The skills are designed to reduce context consumption, prioritize selected context, apply clear stop conditions, and avoid over-engineered recommendations.

## Skills

| Skill | Answers | Use when |
|---|---|---|
| `product-evolution` | What is the highest-value product investment? | Manual-only product investment decisions, MVPs, pilots, roadmap priorities, customer requests, opportunity analysis, and priority arbitration |
| `engineering-architecture` | How should the system evolve safely? | Architecture review, system design, architecture decisions, migration planning, service boundaries, domain/data ownership, architecture debt, reliability strategy, observability architecture, deployment architecture, technical evolution, design challenge, decision support |
| `engineering-delivery` | What is the safest next delivery action? | Diagnosis, investigation, implementation, bug fixes, tests, CI failures, runtime failures, code review, diff review, patch review, commit review, PR review, local refactoring, validation, PR preparation, incremental improvements |

Use `product-evolution` only when explicitly invoked. It owns product decisions before architecture: should we do it, for whom, when, what MVP, how to validate, what should go first, and what not to do.

Use `engineering-architecture` when the question is about technical design, tradeoffs, service boundaries, ownership, migrations, deployment architecture, reliability strategy, technical evolution, or architecture risk.

Use `engineering-delivery` when the request is to diagnose an error, investigate a failure, implement, fix, test, validate, review code, review a diff, review a patch, review a commit, review a PR, refactor locally, prepare a PR, or make the next approved incremental change.

Engineering delivery defaults to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

Use the strict chain when multiple layers are needed: `product-evolution` -> `engineering-architecture` -> `engineering-delivery`.

## Installation

Install the full skill folders when possible, not only `SKILL.md`. The supporting `docs/`, `templates/`, and `examples/` are intentionally loaded on demand and improve behavior after the skill is selected.

The commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

### Install All Skills

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a 0x12th-playbooks/skills/ ~/.agents/skills/
```

Pinned version:

```bash
git clone --branch v0.8.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a 0x12th-playbooks/skills/ ~/.agents/skills/
```

### Install One Skill

Architecture review:

```bash
git clone --branch v0.8.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a 0x12th-playbooks/skills/engineering-architecture ~/.agents/skills/
```

Product evolution:

```bash
git clone --branch v0.8.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a 0x12th-playbooks/skills/product-evolution ~/.agents/skills/
```

Engineering delivery:

```bash
git clone --branch v0.8.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a 0x12th-playbooks/skills/engineering-delivery ~/.agents/skills/
```

### Agent Paths

Common destinations:

- Zed: `~/.agents/skills`
- Claude Code: `~/.claude/skills`
- Codex: `~/.codex/skills`
- Project-local skills: `.agents/skills`

Raw `SKILL.md` URLs are useful for agents that support URL imports, but they do not include supporting `docs/`, `templates/`, or `examples/`:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/product-evolution/SKILL.md
```

See `docs/installation.md` for more installation details.

## Automatic Selection

Most AI coding agents select skills primarily from the skill `name` and frontmatter `description` in each `SKILL.md`. The descriptions in this repository expose common trigger phrases such as architecture review, migration planning, service boundaries, diagnosis, investigation, implementation, bug fixes, tests, CI failures, runtime failures, code review, diff review, and PR review.

`product-evolution` is intentionally manual-only while it is being tuned. Invoke it explicitly with `Use product-evolution`.

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

Product evolution:

```text
Use product-evolution. Should this customer request become roadmap work?
```

```text
Use product-evolution. Which should come first: mobile app or watch notifications?
```

Engineering delivery:

```text
Why is CI failing? Identify the root cause and do not change files.
```

```text
Fix the failing CI test and run the relevant validation.
```

```text
Investigate this runtime exception.
```

```text
Implement the first approved migration step without changing public behavior.
```

```text
Write tests for the selected code.
```

```text
Review this PR.
```

```text
Review this PR for bugs, regressions, and missing tests.
```

## Optional Memory Backends

`0x12th-playbooks` works without any memory system.

The skills are designed to operate from selected context, repository files, code, tests, logs, diffs, and user-provided information.

When an optional memory backend is available through the agent runtime, it may be used as supplemental context for previous architecture decisions, migration history, ADRs, design notes, incident investigations, project conventions, and unresolved follow-ups.

Memory must not replace current repository evidence. Current code, configuration, tests, logs, validation results, and selected context always take precedence over remembered information.

Memory should not be consulted before local evidence and must not broaden investigation scope by itself.

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
│   ├── engineering-architecture/
│   ├── engineering-delivery/
│   └── product-evolution/
├── docs/
├── .github/
├── manifests/
└── CHANGELOG.md
```

## Development And Contribution

Keep skill entrypoints short, move detailed behavior into directly linked docs, and avoid adding new files unless they improve agent behavior. See `docs/authoring-guidelines.md`.

Run consistency checks before release:

```bash
python3 .github/scripts/check_skills.py
```
