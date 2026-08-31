# 0x12th-playbooks

`0x12th-playbooks` is a collection of practical playbooks and agent skills for product decisions, architecture, code review, delivery, migration planning, technical decision-making, and software evolution.

It is not a prompt collection. It is a structured library of reusable skills for AI coding agents that need to review real systems, make technical decisions, implement changes safely, and avoid unnecessary architecture work.

AI coding agents are useful when they stay inside the right scope. They become risky when every local change turns into a broad architecture audit, or every architecture question turns into premature implementation.

This repository separates four common intents:

- **Product evolution:** deciding whether, why, when, and in what scope to invest.
- **Architecture review:** deciding how the system should be designed, migrated, or evolved technically.
- **Engineering code review:** deciding whether a concrete code change is safe to merge.
- **Engineering delivery:** diagnosing, validating, and performing explicitly requested implementation.

The skills are designed to reduce context consumption, prioritize selected context, apply clear stop conditions, and avoid over-engineered recommendations.

## Skills

| Skill | Answers | Use when |
|---|---|---|
| `product-evolution` | What is the highest-value product investment? | Current product assessment, product investment decisions, customer requests, feature scope, MVPs, pilots, roadmap priorities, opportunity analysis, priority arbitration, and smallest useful next step decisions |
| `engineering-architecture` | How should the system evolve safely? | Architecture review, system design, architecture decisions, migration planning, service boundaries, domain/data ownership, architecture debt, reliability strategy, observability architecture, deployment architecture, production readiness, deployment readiness, release readiness, operational readiness, runtime resource review, VPS/server fit assessment, current/target architecture assessment, capacity and scaling review, technical evolution, design challenge, decision support |
| `engineering-code-review` | Is this concrete code change safe to merge? | Selected code/file review, diff/patch/change-set review, commit/range/branch review, GitLab MR and GitHub PR review, incremental re-review, recommendation audit, and read-only comment preparation |
| `engineering-delivery` | What is the safest next delivery action? | Diagnosis, investigation, implementation, bug fixes, tests, CI failures, runtime failures, local refactoring, validation, PR preparation, incremental improvements |

Use `product-evolution` when the question is whether, why, when, for whom, or in what MVP scope to invest, or explicitly asks about current product health, maturity, adoption, retention, or customer value. Explicit invocation is supported but not required. It owns product decisions before architecture: should we do it, for whom, when, what MVP, how to validate, what should go first, what is the smallest useful solution, and what not to do.

Use `engineering-architecture` when the question is about technical design, tradeoffs, service boundaries, ownership, migrations, deployment architecture, production readiness, deployment readiness, release readiness, operational readiness, runtime resource review, VPS/server fit, current architecture, target architecture, capacity and scaling, technical evolution, or architecture risk.

Use `engineering-code-review` when the request is to review selected code, a file, diff, patch, commit, range, branch, GitLab merge request, GitHub pull request, or equivalent concrete change; re-review an updated change; audit existing comments; or prepare review comments.

Use `engineering-delivery` when the request is to diagnose an error, investigate a failure, implement, fix, test, validate, refactor locally, prepare a PR, or make the next approved incremental change.

Engineering delivery defaults to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes. Code review is read-only and hands confirmed fixes to delivery as a separate phase.

When multiple layers are needed, use `product-evolution` before `engineering-architecture`, then select `engineering-code-review` for a concrete implementation assessment or `engineering-delivery` for execution. Review-to-fix work flows from `engineering-code-review` to `engineering-delivery`.

## Installation

Install the full skill folders when possible, not only `SKILL.md`. The supporting `references/`, `templates/`, and `examples/` are intentionally loaded on demand and improve behavior after the skill is selected.

By default, `install.sh` installs into existing agent homes: `~/.agents/skills`, `~/.claude/skills`, and `~/.codex/skills`. It skips missing agent homes so it does not create unused directories. If none exist, it falls back to `~/.agents/skills` for first-time setup.

The installer treats this repository's four skill folders as managed copies. Updates remove stale files inside those folders while preserving every neighboring skill. Keep custom variants in a fork or a separate project-local skill.

The standalone `engineering-code-review` skill is currently unreleased. Install the latest complete bundle so it and the review-free `engineering-delivery` come from the same revision. Pinned `v0.13.1` remains the current released three-skill bundle. If an unrelated neighboring `code-review` skill is installed, the installer warns but never edits it.

The manual commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

### Quick Install

Latest:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh
```

Pinned version:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/v0.13.1/install.sh | sh -s -- ~/.agents/skills v0.13.1
```

Custom target directory:

```bash
curl -fsSL https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/install.sh | sh -s -- ~/.claude/skills
```

### Install All Skills From A Clone

Latest:

```bash
git clone https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

Pinned version:

```bash
git clone --branch v0.13.1 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
./0x12th-playbooks/install.sh ~/.agents/skills
```

### Install Selected Skills

The unreleased review ownership split requires `engineering-code-review` and `engineering-delivery` from the same revision. Install them as a pair:

```bash
git clone --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-code-review/ ~/.agents/skills/engineering-code-review/
rsync -a --delete 0x12th-playbooks/skills/engineering-delivery/ ~/.agents/skills/engineering-delivery/
```

`engineering-architecture` and `product-evolution` remain independently installable from either latest or the current pinned release.

### Agent Paths

Common destinations:

- Zed: `~/.agents/skills`
- Claude Code: `~/.claude/skills`
- Codex: `~/.codex/skills`
- Project-local skills: `.agents/skills`

Raw `SKILL.md` URLs are useful for agents that support URL imports, but they do not include supporting `references/`, `templates/`, or `examples/`:

```text
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-architecture/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-code-review/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/engineering-delivery/SKILL.md
https://raw.githubusercontent.com/0x12th/0x12th-playbooks/master/skills/product-evolution/SKILL.md
```

See `docs/installation.md` for more installation details.

## Automatic Selection

Most AI coding agents select skills primarily from the skill `name` and frontmatter `description` in each `SKILL.md`. The descriptions expose product, architecture/readiness, concrete code/change-set review, and delivery signals while keeping their negative boundaries explicit. `engineering-code-review` is the only auto-invoked owner for selected code, diffs, patches, commits, branches, MRs, and PRs.

`product-evolution` supports soft automatic selection for explicit product health, maturity, adoption, retention, customer value, product scope, MVP, roadmap, priority, customer request, feature scope, and "should we build this?" prompts. Generic project or repository review remains an `engineering-architecture` task. `product-evolution` should not be selected for implementation, debugging, architecture, migration, CI, tests, production readiness, deployment readiness, server/VPS fit, or runtime resource review.

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

```text
Is this ready for production?
```

```text
Can I deploy this to a VPS?
```

```text
Review deployment readiness and identify blockers.
```

```text
What is the current architecture and what should the target architecture be?
```

Product evolution:

You may explicitly invoke it with `Use product-evolution`, but product-value prompts should also route here automatically.

Modes:

- `Quick Assessment`
- `Current Product Assessment`
- `Opportunity Analysis`
- `Pilot Evaluation`
- `Priority Arbitration`
- `Roadmap Planning`

```text
Quick Assessment: should this customer request become roadmap work?
```

```text
Current Product Assessment: assess the current product health and recommend the highest-value next investment.
```

```text
Opportunity Analysis: should we invest in a mobile app, and what is the MVP?
```

```text
Pilot Evaluation: should we run an SSO pilot for this enterprise prospect?
```

```text
Priority Arbitration: which should come first, mobile app or watch notifications?
```

```text
Roadmap Planning: prioritize mobile app, watch notifications, onboarding, and API access.
```

Engineering code review:

```text
Review GitLab MR !42 for confirmed bugs and merge risk. Prepare concise comments, but do not post them.
```

```text
Re-review this updated PR and classify previous findings as resolved, still open, new, or unverifiable.
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
│   ├── engineering-code-review/
│   ├── engineering-delivery/
│   └── product-evolution/
├── docs/
├── .github/
├── manifests/
└── CHANGELOG.md
```

## Development And Contribution

Keep skill entrypoints short, move detailed behavior into directly linked references, and avoid adding new files unless they improve agent behavior. See `docs/authoring-guidelines.md`.

Run consistency checks before release:

```bash
python3 .github/scripts/check_skills.py
sh .github/scripts/check_install.sh
```

Behavioral skill changes should also be checked on the active maintainer
runtimes defined in `docs/behavior-evaluation.md`.
