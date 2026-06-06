# Optional Context Sources

Use optional context sources only when they are already available through the project or agent runtime.

This repository must not require GBrain, MCP memory, external knowledge stores, or any other memory backend.

Skills must continue to work from selected context, repository files, user-provided context, logs, diffs, and normal exploration rules.

Do not install, configure, or require an optional memory backend unless the user explicitly asks for that integration work.

Do not consult memory before local evidence. Use memory only after selected context, repository evidence, logs, diffs, tests, or validation results leave a specific gap that historical context may fill.

## Trust Order

Use this order when sources conflict:

1. Selected context and explicit user instructions for the current task.
2. Current repository files, code, tests, configuration, logs, diffs, and validation results.
3. User-provided background for the current task.
4. Optional memory or historical context.

Memory is not proof of current behavior. Treat remembered information as a lead to verify against current evidence.

Memory must not broaden investigation scope. If current evidence is sufficient, stop without consulting memory.

## Memory Query Policy

- Use optional memory only after a concrete evidence gap remains.
- Use at most 1-3 targeted memory queries per task.
- Query only for prior decisions, migration history, project conventions, incidents, or unresolved follow-ups.
- Treat memory results as unverified until checked against current repository files, code, tests, logs, diffs, or validation results.
- If memory conflicts with current evidence, current evidence wins.
- Mark stale or contradictory memory explicitly.
- Memory must not broaden scope by itself.

## GBrain

GBrain may be used as an optional memory backend when available through MCP or another runtime integration.

Use it as supplemental context for:

- architecture decisions
- migration history
- ADRs and design notes
- incident investigations
- project conventions
- unresolved follow-ups

Repository code, tests, logs, diffs, validation results, and selected context remain the source of truth.

Memory should supplement evidence, never replace evidence.

Memory should not broaden the task scope by itself. If memory mentions unrelated historical issues, ignore them unless they directly affect the selected context or requested decision.

If GBrain is unavailable, continue with the normal skill workflow without changing behavior.
