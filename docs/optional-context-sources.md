# Optional Context Sources

Use optional context sources only when they are already available through the project or agent runtime.

This repository must not require GBrain, MCP memory, external knowledge stores, or any other memory backend for skill execution.

Skills must continue to work from selected context, repository files, user-provided context, logs, diffs, and normal exploration rules.

Do not install, configure, or require an optional memory backend unless the user explicitly asks for that integration work.

## Trust Order

Use this order when sources conflict:

1. Selected context and explicit user instructions for the current task.
2. Current repository files, code, tests, configuration, logs, diffs, and validation results.
3. User-provided background for the current task.
4. Optional memory or historical context.

Memory is not proof of current behavior. Treat remembered information as a lead to verify against current evidence.

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
