# Code Change Rules

Use the repository's existing patterns before introducing new ones.

## Edit Rules

- Read relevant files before editing them.
- Keep diffs narrow and intentional.
- Do not overwrite unrelated user changes.
- Do not use destructive git operations unless explicitly requested.
- Do not introduce new dependencies unless the benefit is clear and the repository already supports that pattern.
- Avoid broad rewrites for local problems.
- Prefer direct fixes over speculative abstraction.
- Add comments only where they clarify non-obvious behavior.

## Refactoring

Refactor only when it directly supports the requested change or materially reduces risk.

Prefer:

- Smaller functions over new frameworks.
- Clear naming over new abstraction.
- Local consolidation over generalized utilities.
- Tests before risky restructuring.

Do not change behavior during refactoring unless the behavior change is explicit and tested.

## Compatibility

Before changing APIs, schemas, contracts, CLI behavior, or deployment configuration, verify that the requested task actually requires it.

If compatibility impact is unclear, stop and recommend architecture review or ask for confirmation.
