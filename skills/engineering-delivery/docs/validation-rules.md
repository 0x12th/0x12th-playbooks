# Validation Rules

Run the narrowest validation that proves the change.

Prefer:

- Targeted unit tests for local logic.
- Targeted integration or contract tests for boundary changes.
- Type checks or linters when the repository uses them.
- CI-equivalent commands when practical.
- Manual smoke checks only when automated checks are unavailable.

## Validation Selection

Use existing repository tooling. Check scripts, package manager commands, Makefiles, task runners, CI config, or README instructions when needed.

Do not invent validation commands when the project provides a clear path.

## If Validation Fails

When validation fails:

1. Determine whether failure is caused by the change.
2. Fix change-related failures when feasible.
3. Report unrelated failures without hiding them.
4. Do not claim validation passed if only part of it ran.

## Final Reporting

Report:

- Commands run
- Pass/fail result
- Any skipped validation and why
- Any residual risk that matters
