# Implementation Workflow

Use this workflow for bounded delivery work. Treat implementation ideas as hypotheses; repository behavior, tests, commands, logs, and diffs provide the evidence.

1. Confirm the requested outcome, selected scope, and acceptance criteria.
2. Inspect the smallest relevant code path and existing validation tooling.
3. Identify the minimal safe change and the evidence that would prove it.
4. For bugs and CI failures, reproduce the failure or identify a concrete observable failure signal before patching when practical.
5. Edit only files required for the change.
6. Add or update focused tests when risk justifies it.
7. Run the most relevant validation available.
8. If validation fails, use the result to refine the hypothesis and retry only while each attempt produces new evidence.
9. Summarize changed files, validation, and residual risk.

## Execution Discipline

- Every read, command, edit, or validation step should produce an observable result: a failing test, passing test, log line, diff, type error, runtime behavior, or explicit missing-evidence statement.
- Prefer environment validation over reasoning alone. Do not claim behavior is fixed because the code "looks right."
- Keep the loop short: observe, change, validate, then stop or repeat with new evidence.
- Do not make speculative edits when the result cannot be checked. For medium- or high-risk changes, stop instead of guessing.
- Repeated failures should become regression tests, focused validators, clearer docs, or automation when practical.

## Mode-Specific Loops

- **Implementation:** define acceptance criteria, make the narrow change, validate the new behavior.
- **Bug fix:** reproduce or inspect the failure, identify root cause, patch root cause, add regression coverage where practical, rerun the failing path.
- **CI fix:** start from the failing log or command, reproduce locally when feasible, fix the cause without weakening useful checks, rerun the closest CI-equivalent validation.
- **Validation:** find the repository-supported command, run the narrowest meaningful check, classify failures as change-related, pre-existing, or inconclusive.
- **Test work:** protect behavior or contracts; do not add tests that only mirror implementation details.

## Scope Control

- Make one logical change at a time.
- Prefer behavior-preserving changes unless the user asks for behavior change.
- Keep refactors local.
- Avoid unrelated cleanup.
- Preserve public contracts unless the task explicitly changes them.
- Preserve user changes in the working tree.

## Exploration Budget

- Start with selected or named files.
- Expand only to direct callers, callees, tests, schemas, configuration, or CI definitions needed to make and validate the change.
- Stop exploring when the failure, change point, and validation path are known.
- If a bounded pass cannot identify a safe change point, state the missing evidence instead of continuing repository-wide exploration.

## When to Stop

Stop and ask or hand back a decision when:

- The implementation requires an architecture decision not already made.
- The requested change would change ownership, contracts, data migration strategy, or deployment architecture.
- Validation cannot be run and risk is high.
- The same validation failure repeats after two reasonable attempts without new evidence.
- The only available next step is a broad rewrite, new dependency, destructive operation, or public contract change not requested by the user.
- The failure cannot be reproduced and no other trustworthy validation signal exists for a risky behavior change.
- Requirements conflict.

For architecture decisions, recommend `engineering-architecture-review`.
