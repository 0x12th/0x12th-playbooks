---
name: engineering-architecture-review
description: Use for architecture review and system design questions: architecture decisions, migration planning, service boundaries, domain boundaries, ownership, data ownership, architecture debt, reliability strategy, observability architecture, deployment architecture, system evolution, design challenge, tradeoff analysis, and technical decision support. Do not use for implementation, bug fixes, tests, CI fixes, code review, or local refactoring; use engineering-delivery for those.
---

# Engineering Architecture Review

Use this skill to answer:

```text
How should the system be designed?
```

The goal is practical architecture decision-making: reduce long-term maintenance cost, operational risk, migration risk, and cognitive load without defaulting to rewrites, microservices, or fashionable abstractions.

This is a review and decision-support skill. It does not implement code changes.

## Boundaries

Use this skill for:

- Architecture decisions
- Migration planning and migration review
- Service boundaries
- Domain boundaries
- Ownership and data ownership
- Architecture debt
- Reliability strategy
- Observability architecture
- Deployment architecture
- System evolution
- Design challenge
- Decision support
- Implementation planning before code changes

Do not use this skill for:

- Bug fixes
- Writing tests
- CI fixes
- Code review of diffs or PRs
- Local refactoring
- Routine coding tasks
- PR preparation
- Direct implementation work

When the user asks to implement, fix, test, validate, refactor locally, or prepare a PR, use `engineering-delivery`. If that work requires an architecture decision first, recommend `engineering-architecture-review` before implementation.

## Intent Detection

Choose this skill when the request is about whether, why, where, or how the system should evolve.

Architecture-review examples:

- "Should we merge these two tightly coupled modules?"
- "How should we start merging these services step by step?"
- "Review the service architecture."
- "Should background jobs move to a different queue runtime?"
- "Challenge this design."
- "What are the risks in this migration plan?"
- "Where should this ownership boundary live?"

Do not select this skill for execution examples:

- "Implement the first merge step."
- "Write tests."
- "Why is CI failing?"
- "Move this job to the approved queue runtime."
- "Fix this bug."

Use `engineering-delivery` for those.

## Mode Selection

Use one mode per response unless the user explicitly asks for multiple outputs.

- **Quick scan**: 3-5 highest-impact findings only. Use for fast assessment, second opinion, or prioritization.
- **Focused review**: One subsystem, service, module, migration, performance issue, reliability concern, deployment path, or selected context.
- **Full review**: Broad architecture assessment with architecture model, ranked findings, roadmap, and uncertainty.
- **Design challenge**: Critique a proposal, challenge assumptions, compare alternatives, and decide whether the proposal should exist.
- **Decision support**: Help choose between options using evidence, economics, tradeoffs, and confidence gates.
- **Migration review**: Evaluate migration safety, coexistence, rollback, validation, ownership, and operational readiness.

Do not implement code in this skill. For code changes, switch to `engineering-delivery`.

## Required Rules

Always apply:

- `docs/language-rules.md`
- `docs/communication-rules.md`
- `docs/selected-context-rules.md` when selected code, pasted snippets, or named files are present
- `docs/exploration-budget.md`
- `docs/anti-overengineering.md`
- `docs/economics.md` before recommending architecture change

Load mode-specific docs only when needed:

- `docs/review-rules.md` for quick scan, focused review, and full review
- `docs/decision-support.md` for choosing between options
- `docs/design-challenge.md` for challenging a proposal
- `docs/migration-review.md` for migrations, extractions, replacements, and staged system evolution

Supporting templates:

- `templates/checklists.md`
- `templates/architecture-review-report.md`
- `templates/improvement-roadmap.md`
- `templates/task-breakdown.md`
- `templates/adr-draft.md`

Examples:

- `examples/quick-scan.md`
- `examples/focused-review.md`
- `examples/design-challenge.md`
