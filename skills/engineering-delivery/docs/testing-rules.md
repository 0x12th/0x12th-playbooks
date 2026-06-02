# Testing Rules

Let test coverage scale with risk and blast radius.

## Add Tests When

- Fixing a bug with a reproducible failure.
- Changing behavior.
- Touching shared logic.
- Changing contracts, validation, parsing, persistence, or error handling.
- Refactoring code that lacks obvious safety.

## Keep Tests Focused

- Prefer regression tests for the changed behavior.
- Prefer unit or component tests for local logic.
- Use integration or contract tests when boundaries are involved.
- Avoid broad end-to-end tests for narrow fixes unless the repository already uses them for that workflow.

## Test Repair

When fixing failing tests:

- Identify whether the test or product behavior is wrong.
- Do not weaken assertions to make tests pass.
- Preserve meaningful coverage.
- Update snapshots only when the behavior change is intentional.

## Missing Test Infrastructure

If tests cannot be added or run, state why and use the next best validation path.
