# Optional Context Sources

Use optional context sources only when they are already available through the project or agent runtime.

This repository must not require GBrain, MCP memory, external knowledge stores, or any other memory backend for skill execution.

Skills must continue to work from selected context, repository files, user-provided context, logs, diffs, and normal exploration rules.

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

If GBrain is unavailable, continue with the normal skill workflow without changing behavior.