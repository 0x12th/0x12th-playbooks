# Validation Rules

Run the narrowest validation that proves the change. Validation is evidence, not ceremony.

Prefer:

- Targeted unit tests for local logic.
- Targeted integration or contract tests for boundary changes.
- Type checks or linters when the repository uses them.
- CI-equivalent commands when practical.
- Manual smoke checks only when automated checks are unavailable.

## Validation Selection

Use existing repository tooling. Check scripts, package manager commands, Makefiles, task runners, CI config, or README instructions when needed.

Do not invent validation commands when the project provides a clear path.

Choose validation by risk:

- **Low risk:** targeted test, formatter, linter, or static check that covers the edited area.
- **Medium risk:** targeted tests plus type, lint, integration, or contract checks used by the repository.
- **High risk:** reproduce the original failure or baseline, run targeted checks, and run the closest practical CI-equivalent command. If this is not possible, state the residual risk clearly.

## Validation Loop

1. Establish the expected observable result before running validation.
2. Run the narrowest meaningful command or smoke check.
3. Classify the result as pass, change-related failure, pre-existing failure, or inconclusive.
4. For change-related failures, fix the cause and rerun the same proof when practical.
5. Stop after repeated failures that no longer produce new evidence.

## If Validation Fails

When validation fails:

1. Determine whether failure is caused by the change.
2. Fix change-related failures when feasible.
3. Report unrelated failures without hiding them.
4. Do not claim validation passed if only part of it ran.

Do not convert a failing validation path into a weaker validation path unless the original path is unavailable or unrelated to the change.

## Confidence

State confidence in proportion to validation:

- **High:** the failure was reproduced or baseline was known, the change was validated by the relevant automated check, and residual risk is low.
- **Medium:** targeted validation passed, but broader CI-equivalent coverage was unavailable or unnecessary for the scope.
- **Low:** validation was static, partial, manual-only, skipped, or blocked.

## Final Reporting

Report:

- Commands run
- Pass/fail result
- Any skipped validation and why
- Any residual risk that matters
