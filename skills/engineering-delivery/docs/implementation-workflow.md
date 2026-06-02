# Implementation Workflow

Use this workflow for bounded delivery work.

1. Confirm the requested outcome from the prompt and selected context.
2. Inspect the smallest relevant code path.
3. Identify the minimal safe change.
4. Edit only files required for that change.
5. Add or update focused tests when risk justifies it.
6. Run the most relevant validation available.
7. Summarize changed files, validation, and residual risk.

## Scope Control

- Make one logical change at a time.
- Prefer behavior-preserving changes unless the user asks for behavior change.
- Keep refactors local.
- Avoid unrelated cleanup.
- Preserve public contracts unless the task explicitly changes them.
- Preserve user changes in the working tree.

## When to Stop

Stop and ask or hand back a decision when:

- The implementation requires an architecture decision not already made.
- The requested change would change ownership, contracts, data migration strategy, or deployment architecture.
- Validation cannot be run and risk is high.
- Requirements conflict.

For architecture decisions, recommend `engineering-architecture-review`.
