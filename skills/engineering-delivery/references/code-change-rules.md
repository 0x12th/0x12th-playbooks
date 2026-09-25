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

## Risk-Based Change Tiers

Use the lowest-risk action that can satisfy the request.

- **Low risk:** local implementation detail, small test, documentation clarification, or behavior-preserving cleanup. Keep the edit local and run targeted validation when available.
- **Medium risk:** shared logic, error handling, parsing, validation, configuration, or user-visible behavior. Inspect direct dependencies, add or update focused tests where practical, and run the narrowest proof.
- **High risk:** public APIs, schemas, persistence, migrations, deployment configuration, authentication, authorization, security, data deletion, dependency changes, or broad rewrites. Confirm the task requires the change, preserve compatibility where possible, and use stronger validation. If the impact is unclear, stop.

## Change Safety

- Patch root cause, not only the visible symptom.
- Prefer adding guardrails near the boundary where invalid state enters the system.
- Keep compatibility unless the user explicitly requests a breaking change.
- Do not weaken tests, types, lint rules, or assertions to make validation pass.
- Do not hide failures by broadening catches, swallowing errors, skipping checks, or changing defaults without evidence.
- Separate preparation from commit for risky actions: stage data, scripts, or config changes in reviewable form before applying irreversible effects.

## Refactoring

Refactor only when it directly supports the requested change or materially reduces risk.

Prefer:

- Smaller functions over new frameworks.
- Clear naming over new abstraction.
- Local consolidation over generalized utilities.
- Tests before risky restructuring.

Do not change behavior during refactoring unless the behavior change is explicit and tested.

### Local Refactor or Bounded Rebuild

A local refactor improves the existing structure while preserving its contract.
A rebuild reconstructs the selected artifact from verified requirements and
facts when the old organization prevents a clear, safe solution. For prose,
preserve facts and intent rather than the old outline; for code, preserve
supported behavior and compatibility rather than incidental helper structure.

Both are implementation choices, not new work modes. Default to local edits;
choose a rebuild only when the authorized outcome requires it and evidence
shows why incremental edits are insufficient. Establish the facts/contracts,
scope, preservation constraints, and independent validation before replacing
the artifact. The smallest safe solution is not necessarily the smallest diff.

A rebuild is not permission for repository-wide redesign. If it requires an
undecided architecture, migration, ownership, or product choice, stop for that
decision. Keep broad rewrites in the high-risk tier and preserve user work.

## Compatibility

Before changing APIs, schemas, contracts, CLI behavior, or deployment configuration, verify that the requested task actually requires it.

Changing a shared client's failure signal from returned error data to an exception (or the reverse) changes its consumer contract. Trace affected callers, exception handlers, foreground/background paths, and existing retry or fallback behavior; follow indirect calls only when evidence of impact requires it. A confirmed broken recovery path must be resolved within the authorized change or reported as a blocker; do not silently defer it or invent a new business recovery policy. When safe, validate the client at a controlled transport boundary and affected consumer behavior; do not require live services, mandate a specific test harness, or add production seams solely for test convenience.

If compatibility impact is unclear, stop and ask for the required architecture decision or confirmation.
