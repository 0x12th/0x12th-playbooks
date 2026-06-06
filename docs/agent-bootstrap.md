# Agent Bootstrap

Use this short text in `AGENTS.md`, `CLAUDE.md`, or similar project instructions when an agent does not reliably discover installed skills automatically.

```text
Use installed 0x12th-playbooks skills when relevant.

Use engineering-architecture-review for architecture review, architecture decisions, migrations, service boundaries, domain boundaries, ownership, data ownership, system evolution, design challenge, tradeoff analysis, and technical decision support.

Use engineering-delivery for diagnosis, investigation, implementation, tests, bug fixes, CI failures, runtime failures, code review, diff review, patch review, validation, PR preparation, local refactoring, and incremental improvements.

For delivery work, default to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

If both skills seem relevant, decide architecture first with engineering-architecture-review, then use engineering-delivery for implementation.

Skills influence behavior silently. Do not announce skill execution, recommend the current skill, or explain internal skill routing to the user.
```
