---
name: engineering-delivery
description: >-
  Use for safe engineering delivery work: diagnosis, investigation,
  implementation, coding, bug fixes, tests, CI failures, runtime failures,
  validation, code review, diff review, patch review, review this change,
  review this commit, review this PR, local refactoring, PR preparation, and
  incremental improvements. Default to read-only diagnosis unless the user
  explicitly asks to implement, fix, patch, modify, update, refactor, or apply
  changes. Do not use for architecture decisions, service extraction strategy,
  migration strategy, platform evolution, or long-term tradeoff analysis.
---

# Engineering Delivery

Answer:

```text
What is the safest next delivery action?
```

This is a delivery playbook for diagnosing, investigating, reviewing, validating, and only when explicitly requested, making bounded code changes while preserving user work and minimizing regression risk.

## Boundaries

Applies to:

- Diagnosis
- Investigation
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

Does not apply to:

- Architecture decisions
- Service extraction strategy
- Migration strategy
- Platform evolution
- Long-term tradeoff analysis
- Broad architecture assessment

When an architecture decision is required before delivery work can continue, stop and state the decision that is missing. Do not route, announce, or explain skill selection.

## Intent Detection

Default to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

Read-only diagnosis, investigation, validation, or review examples:

- "Why is CI failing?"
- "Analyze this error."
- "Look at this."
- "Check this."
- "Where is the problem?"
- "Is this related?"
- "What changed?"
- "Investigate this runtime exception."
- "Review this PR."
- "Review this PR for bugs and missing tests."
- "Validate this change."

Implementation examples:

- "Implement the first merge step."
- "Write tests."
- "Move this job to the approved queue runtime."
- "Fix this bug."
- "Fix the failing CI test."
- "Patch this failure."
- "Refactor this function."
- "Prepare the PR summary."

Architecture examples that require a decision before delivery work:

- "Should we merge these services?"
- "Should background jobs move to a different queue runtime?"
- "What should the service boundary be?"
- "Review this migration strategy."
- "Challenge this design."

## Work Modes

Choose the smallest useful mode:

- **Diagnosis**: explain the failure, likely cause, and next safe action without editing files.
- **Investigation**: gather only the evidence needed to answer when selected context is insufficient.
- **Implementation**: make a bounded code or config change only after an explicit edit request.
- **Validation**: run checks, explain pass/fail results, and classify failures.
- **Review**: assess selected code, diffs, commits, or PRs for bugs, regressions, missing tests, and delivery risk.

## Execution Discipline

Use the smallest safe execution loop:

1. Classify the mode: diagnosis, investigation, implementation, validation, or review.
2. Start from the strongest local evidence: selected context, stack traces, logs, failing tests, provided files, provided diffs, then named repository files.
3. For runtime failures, follow the traceback before exploring the repository. Traceback beats repository exploration.
4. In read-only modes, answer the question and stop when the evidence is sufficient.
5. In implementation mode, make the smallest behavior-preserving or behavior-targeted change and validate it.
6. Report only findings, changed files when applicable, validation result, remaining risk, and next safe step.

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
Do not consult memory before current local evidence. Use memory only as supplemental context for prior decisions, project conventions, or investigation history after selected context, repository files, code, tests, logs, diffs, validation results, and explicit user instructions have been checked.
Treat memory as unverified until supported by current evidence. Memory must not replace reproduction, inspection, tests, or validation, and must not broaden the investigation or change scope by itself.
Do not require, install, configure, or depend on a memory backend.

## Required Rules

Always apply:

- `docs/language-rules.md`
- `docs/communication-rules.md`
- `docs/selected-context-rules.md` for evidence priority and scope control
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
