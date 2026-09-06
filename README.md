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

| Skill | Primary decision |
|---|---|
| `product-evolution` | Product value, investment, scope, priority and explicit product health |
| `engineering-architecture` | Technical design/evolution and architecture/readiness decisions |
| `engineering-code-review` | Read-only selected-code and concrete change-set assessment |
| `engineering-delivery` | Diagnosis, validation and authorized scoped implementation |

See [Skill Selection](docs/skill-selection.md) for canonical routing, mode defaults and mixed-intent examples. Each installed skill selects its own mode.

Diagnostic questions and assessment-only delivery requests stay read-only. Explicit intent for a result requiring project changes authorizes scoped edits when the target is clear—not just a fixed list of verbs. Release preparation does not authorize publication, push or destructive actions. Review-and-fix completes read-only findings first, then applies delivery rules in a bounded implementation phase; no runtime handoff facility is required.

## Installation

Install the full skill folders when possible, not only `SKILL.md`. The supporting `references/`, `templates/`, and `examples/` are intentionally loaded on demand and improve behavior after the skill is selected.

The current `master` installer targets existing `~/.agents`, `~/.claude`, `~/.codex`, and active Hermes homes, installing into each home's `skills/`. Hermes uses nonempty `$HERMES_HOME`, otherwise `~/.hermes`; other profiles are not scanned. Missing homes stay absent. If none exist, only `~/.agents/skills` is created for first-time setup.

The installer treats this repository's four skill folders as managed copies. Updates remove stale files inside those folders while preserving every neighboring skill. Keep custom variants in a fork or a separate project-local skill.

Current `master` checks all destinations before modifying them, rejects unsafe/symlink/self-install targets, stages the complete bundle, and rolls back all selected homes on publication failure. Failed rollback retains backups and reports their paths. Stop readers and other writers during updates: this is not a crash-safe or concurrent atomic switch. See [update safety](docs/installation.md#update-safety-current-master) for the exact boundary and recovery limitations.

Hermes profile-local skills override same-named external skills; trusted project skills have higher priority still. Prefer one authoritative bundle source and migrate duplicates manually—the installer never removes duplicates from other locations. See [Hermes installation](docs/installation.md#hermes-agent).

The standalone `engineering-code-review` skill is included in `v0.14.0`. Install the complete bundle so it and the review-free `engineering-delivery` come from the same revision. If an unrelated neighboring `code-review` skill is installed, the installer warns but never edits it.

The manual commands below use `~/.agents/skills` as a common example. Replace it with the skills directory used by your agent setup.

### Quick Install

The pinned `v0.14.0` commands below are historical: that installer does not include the newer safeguards or Hermes defaults. To combine a pinned bundle with current safeguards, use the `master/install.sh` URL with `v0.14.0` as the second argument.

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

### Install All Skills From A Clone

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

### Install Selected Skills

The review ownership split requires `engineering-code-review` and `engineering-delivery` from the same revision. The historical manual commands below are not transactional; inspect targets for symlinks, back up both folders, stop readers, and restore both if either command fails. Prefer the current full-bundle installer for automatic rollback.

```bash
git clone --branch v0.14.0 --depth 1 https://github.com/0x12th/0x12th-playbooks.git
mkdir -p ~/.agents/skills
rsync -a --delete 0x12th-playbooks/skills/engineering-code-review/ ~/.agents/skills/engineering-code-review/
rsync -a --delete 0x12th-playbooks/skills/engineering-delivery/ ~/.agents/skills/engineering-delivery/
```

`engineering-architecture` and `product-evolution` remain independently installable from either latest or `v0.14.0`.

### Agent Paths

Common destinations:

- Zed: `~/.agents/skills`
- Claude Code: `~/.claude/skills`
- Codex: `~/.codex/skills`
- Hermes Agent: `${HERMES_HOME:-$HOME/.hermes}/skills`
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

Agents primarily select from each skill's `name` and frontmatter `description`; each entry point contains its own triggers and safety core. Selection does not require repository docs at runtime. See [Skill Selection](docs/skill-selection.md) for the cross-skill contract.

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
