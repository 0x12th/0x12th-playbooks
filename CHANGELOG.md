# Changelog

All notable changes to this repository are documented in this file.

## 0.3.3 - 2026-06-04

### Fixed

- Reformatted skill frontmatter descriptions as YAML folded scalars for better parser compatibility and readability.

## 0.3.2 - 2026-06-03

### Improved

- Tightened communication rules to suppress implementation planning notes, internal comparison notes, and reasoning about what should be copied, reused, adapted, or investigated.
- Added stricter single-language response guidance and explicit mixed-language failure criteria.
- Updated README, installation docs, and manifest links to the current `v0.3.2` release and `master` branch.

## 0.3.1 - 2026-06-03

### Added

- Added generic project prompt selection guidance for short requests such as "Look at this project" and "What would you improve?"

### Improved

- Clarified that generic project-level prompts should use `engineering-architecture-review` in quick scan mode unless the user explicitly asks for implementation, tests, fixes, or diff review.
- Clarified that a dirty worktree is not selected context for delivery code review mode.

## 0.3.0 - 2026-06-03

### Added

- Added `engineering-delivery` skill for implementation, bug fixes, tests, CI fixes, validation, PR preparation, and local refactoring.
- Added skill-level docs for language rules, selected-context priority, communication discipline, validation, implementation workflow, code-change rules, code review rules, and testing rules.
- Added delivery code review mode for reviewing selected code, diffs, and PRs without turning them into architecture audits.
- Added architecture decision support mode.
- Added explicit architecture exploration budgets.
- Added dedicated anti-overengineering rules.
- Added `manifests/skills.json` as machine-readable skill metadata.
- Added automatic selection guidance and `docs/agent-bootstrap.md` for project-level agent instructions.
- Added repository docs for installation, skill selection, repository structure, and authoring guidelines.

### Changed

- Renamed and repositioned the repository as `0x12th-playbooks`.
- Decomposed the monolithic architecture skill into a compact `SKILL.md` plus supporting docs.
- Clarified architecture and delivery skill boundaries.
- Improved automatic skill selection through stronger frontmatter descriptions and intent examples.
- Clarified that install paths are examples and should match each agent setup.
- Reduced default repository-wide exploration.
- Moved implementation work out of `engineering-architecture-review` and into `engineering-delivery`.

### Removed

- Removed architecture implementation mode.
- Removed planned platform-specific manifests for Zed, Claude Code, and Codex until a real automated consumption scenario exists.

## 0.2.0 - 2026-06-01

### Added

- Architecture Decision Framework for challenging assumptions, comparing alternatives, validating problem existence, and applying confidence gates.
- Evidence Collection Rules for bounded quick scans, stop conditions, early findings, and finding quality.
- Prioritization and cost/benefit guidance that separates severity from what should be worked on next.

### Changed

- Design challenge mode now argues against weak proposals instead of only improving them.
- Quick scan mode now favors fewer high-value findings, disciplined exploration, and concise findings-only output.
- Review mode and implementation mode are now explicitly separated.

### Improved

- README installation flow now surfaces setup earlier and pins examples to `v0.2.0`.
- Examples now match the updated quick scan and design challenge output formats.

## 0.1.0 - 2026-05-31

### Added

- Initial `engineering-architecture-review` Zed Agent Skill.
- Architecture review workflow for quick scans, focused reviews, full reviews, implementation mode, and design challenge mode.
- Severity model: Critical, High, Medium, Low.
- Finding format covering problem, impact, root cause, proposed solution, complexity, risk, expected benefit, and evolution cost.
- Evolution-cost guidance covering operational cost, team cognitive load, migration cost, 1-3 year maintenance cost, and complexity delta.
- Organizational review guidance for ownership clarity, team autonomy, cross-team dependencies, and process problems disguised as architecture problems.
- Performance review guidance for CPU, memory, queues, network, database contention, resource utilization, and capacity limits.
- Migration review guidance for incremental rollout, old/new path coexistence, rollback, correctness validation, and observability.
- Communication rules to avoid filler commentary, exposed internal thinking, and unnecessary narration.
- Supporting templates for checklists, architecture review reports, improvement roadmaps, task breakdowns, and ADR drafts.
- Example outputs for quick scan, focused review, design challenge, and implementation mode.
