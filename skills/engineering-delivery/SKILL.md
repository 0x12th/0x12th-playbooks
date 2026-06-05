---
name: engineering-delivery
description: >-
  Use for safe engineering execution: implementation, coding, bug fixes, tests,
  CI fixes, validation, code review, diff review, patch review, review this change,
  review this commit, review this PR, local refactoring, PR preparation, and
  incremental improvements. Do not use for architecture decisions, service
  extraction strategy, migration strategy, platform evolution, or long-term
  tradeoff analysis; recommend engineering-architecture-review first when those
  decisions are required.
---

# Engineering Delivery

Use this skill to answer:

```text
How should this change be implemented safely?
```

This is an execution skill for making bounded, validated code changes while preserving user work and minimizing regression risk.

## Boundaries

Use this skill for:

- Implementation
- Coding tasks
- Bug fixes
- Tests
- CI fixes
- Code review
- Local refactoring
- Validation
- PR preparation
- Incremental improvements

Do not use this skill for:

- Architecture decisions
- Service extraction strategy
- Migration strategy
- Platform evolution
- Long-term tradeoff analysis
- Broad architecture assessment

When architecture decisions are required, recommend `engineering-architecture-review` first. After the decision is made, use `engineering-delivery` to implement the next safe step.

## Intent Detection

Delivery examples:

- "Implement the first merge step."
- "Write tests."
- "Why is CI failing?"
- "Move this job to the approved queue runtime."
- "Fix this bug."
- "Refactor this function."
- "Review this PR for bugs and missing tests."
- "Validate this change."
- "Prepare the PR summary."

Architecture examples that should use `engineering-architecture-review` first:

- "Should we merge these services?"
- "Should background jobs move to a different queue runtime?"
- "What should the service boundary be?"
- "Review this migration strategy."
- "Challenge this design."

## Work Modes

Choose the smallest useful mode:

- **Implementation**: make a bounded code or config change and validate it.
- **Bug fix**: reproduce or inspect the failure, patch root cause, add regression coverage where practical.
- **Test work**: add or repair tests that protect behavior, contracts, or regressions.
- **CI fix**: diagnose CI failure from logs or commands, fix the cause, rerun relevant validation.
- **Code review**: review selected code, diff, or PR for bugs, regressions, missing tests, and delivery risk.
- **Local refactor**: improve local clarity or maintainability without changing behavior.
- **Validation**: run checks, explain failures, and identify the next safe action.
- **PR preparation**: summarize changes, validation, risks, and follow-ups.

## Execution Discipline

Use the smallest safe execution loop:

1. Identify the requested change or failure.
2. Inspect only the selected or directly relevant files first.
3. Make the smallest behavior-preserving or behavior-targeted change.
4. Run the most relevant validation available.
5. Report changed files, validation result, remaining risk, and next safe step.

Do not broaden the task unless current evidence shows the selected scope is insufficient.

Do not fix unrelated issues discovered during the task. Mention them as follow-ups only when they materially affect the requested change.

Do not treat a change as complete without either validation or a clear explanation of why validation could not be run.

## Risk Control

Prefer local, reversible changes.

Before editing shared contracts, public APIs, migrations, deployment configuration, CI pipelines, dependency versions, or generated files, verify that the change is required for the requested task.

For destructive, broad, or hard-to-revert changes, explain the risk and choose a smaller step when possible.

Preserve user work. Do not overwrite unrelated changes.

## Optional Context Sources

Optional memory backends may be used only when already available through the project or agent runtime.
Use memory only as supplemental context for prior decisions, project conventions, or investigation history. Current selected context, repository files, code, tests, logs, diffs, validation results, and explicit user instructions remain the source of truth.
Treat memory as unverified until supported by current evidence. Memory must not replace reproduction, inspection, tests, or validation, and must not broaden the change scope by itself.
Do not require, install, configure, or depend on a memory backend to use this skill.

## Required Rules

Always apply:

- `docs/language-rules.md`
- `docs/communication-rules.md`
- `docs/selected-context-rules.md` when selected code, pasted snippets, or named files are present
- `docs/implementation-workflow.md`
- `docs/code-change-rules.md`
- `docs/validation-rules.md`

Load only when needed:

- `docs/testing-rules.md` for tests and regression coverage
- `docs/code-review-rules.md` for reviewing selected code, diffs, or PRs

Supporting templates:

- `templates/change-plan.md`
- `templates/pr-summary.md`

Examples:

- `examples/implementation.md`
- `examples/bug-fix.md`
- `examples/code-review.md`
- `examples/tests.md`
- `examples/ci-fix.md`
