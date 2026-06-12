# Agent Bootstrap

Use this short text in `AGENTS.md`, `CLAUDE.md`, or similar project instructions when an agent does not reliably discover installed skills automatically.

```text
Use installed 0x12th-playbooks skills when relevant.

Use product-evolution when the primary question is whether to do something, why, for whom, when, what MVP, how to validate, what has higher priority, whether a customer request should become product work, or what the smallest useful solution is. Explicit invocation is allowed but not required.

Use engineering-architecture for architecture review, architecture decisions, migrations, service boundaries, domain boundaries, ownership, data ownership, system evolution, technical design, technical sequencing, production readiness, deployment readiness, release readiness, operational readiness, runtime resource review, VPS/server fit, current architecture, target architecture, capacity and scaling review, design challenge, tradeoff analysis, and technical decision support.

Use engineering-delivery for diagnosis, investigation, implementation, tests, bug fixes, CI failures, runtime failures, code review, diff review, patch review, validation, PR preparation, local refactoring, and incremental improvements.

Do not use engineering-delivery for production readiness, deployment readiness, server/VPS fit, runtime resource review, current architecture, target architecture, or repository-wide technical review. Those require engineering-architecture first.

For delivery work, default to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

If multiple layers are needed, use the order product-evolution -> engineering-architecture -> engineering-delivery.

Skills influence behavior silently. Do not announce skill execution, recommend the current skill, or explain internal skill routing to the user.
```
