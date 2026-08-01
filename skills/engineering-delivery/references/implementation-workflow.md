# Implementation Workflow

Use this workflow for bounded delivery work. Treat implementation ideas as hypotheses; repository behavior, tests, commands, logs, and diffs provide the evidence.

Implementation is not the default mode. Start read-only unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

1. Classify the requested mode: diagnosis, investigation, implementation, validation, or review.
2. Confirm the selected scope and question being answered.
3. Inspect the strongest local evidence first.
4. For bugs, CI failures, and runtime failures, identify a concrete observable failure signal before patching when practical.
5. In read-only modes, answer the question once evidence is sufficient.
6. In implementation mode, edit only files required for the change.
7. Add or update focused tests when risk justifies it.
8. Run the most relevant validation available.
9. If validation fails, use the result to refine the hypothesis and retry only while each attempt produces new evidence.
10. Summarize findings, changed files when applicable, validation, and residual risk.

## Execution Discipline

- Every read, command, edit, or validation step should produce an observable result: a failing test, passing test, log line, diff, type error, runtime behavior, or explicit missing-evidence statement.
- Prefer environment validation over reasoning alone. Do not claim behavior is fixed because the code "looks right."
- Keep the loop short: observe, change, validate, then stop or repeat with new evidence.
- Do not make speculative edits when the result cannot be checked. For medium- or high-risk changes, stop instead of guessing.
- Repeated failures should become regression tests, focused validators, clearer docs, or automation when practical.

## Mode-Specific Loops

- **Diagnosis:** inspect provided evidence, identify the most likely cause, state confidence and missing evidence, and do not edit files.
- **Investigation:** expand only when selected evidence is insufficient; stop when the answer is supported.
- **Implementation:** define acceptance criteria, make the narrow change, validate the new behavior.
- **Validation:** find the repository-supported command, run the narrowest meaningful check, classify failures as change-related, pre-existing, or inconclusive.
- **Review:** evaluate selected code or changes for bugs, regressions, missing tests, and delivery risk.

## Traceback-First Debugging

Traceback beats repository exploration.

For runtime failures:

1. Follow the traceback before searching broadly.
2. Identify the first failing application frame.
3. Validate the inputs and state at the failing line.
4. Form the simplest hypothesis that explains the observed failure.
5. Expand investigation only if the traceback path is insufficient.

Do not start with repository-wide exploration when a stack trace, exception, failing test, or log already identifies a path.

## Scope Control

- Make one logical change at a time.
- Prefer behavior-preserving changes unless the user asks for behavior change.
- Keep refactors local.
- Avoid unrelated cleanup.
- Preserve public contracts unless the task explicitly changes them.
- Preserve user changes in the working tree.

## Exploration Budget

- Start with selected context, stack traces, logs, failing tests, provided files, provided diffs, then named files.
- Expand only to direct callers, callees, tests, schemas, configuration, or CI definitions needed to answer the question or validate the change.
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

For architecture decisions, state the missing decision instead of continuing delivery work.
