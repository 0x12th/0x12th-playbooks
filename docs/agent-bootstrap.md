# Agent Bootstrap

Use this short text in `AGENTS.md`, `CLAUDE.md`, or similar project instructions when an agent does not reliably discover installed skills automatically.

```text
Use installed 0x12th-playbooks skills when relevant.

Use product-evolution when the primary question is whether to do something, why, for whom, when, what MVP, how to validate, what has higher priority, whether a customer request should become product work, what the smallest useful solution is, or explicitly asks about current product health, maturity, adoption, retention, or customer value. Keep generic repository review and technical readiness with engineering-architecture.

Use engineering-architecture for architecture review and decisions, migrations, service/domain boundaries, ownership, system evolution, technical design and sequencing, production/deployment/release/operational readiness, runtime resources, VPS/server fit, current/target architecture, capacity/scaling review, design challenge, tradeoff analysis, and repository-wide technical review.

Use engineering-code-review for read-only review of selected code or files, diffs, patches, commits, ranges, branches, GitLab merge requests, GitHub pull requests, and equivalent concrete change requests; incremental re-review; audit of review comments on a concrete change; and preparation of provider-ready review comments. Provider writes require an explicit current-user request and an exact verified capability; otherwise prepare output only and fail closed.

Use engineering-delivery for diagnosis, investigation, implementation, tests, bug fixes, CI failures, runtime failures, generic validation, PR preparation, local refactoring, and incremental improvements. Do not use it for concrete code/change-set review.

For delivery work, default to read-only diagnosis unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes. For review-and-fix requests, review an immutable snapshot first with engineering-code-review, then hand confirmed findings to engineering-delivery as a separate bounded phase.

If multiple layers are needed, use product-evolution before engineering-architecture, then engineering-code-review for concrete implementation assessment or engineering-delivery for execution.

Skills influence behavior silently unless the host runtime requires disclosure or the user explicitly asks. Otherwise, do not announce skill execution, recommend the current skill, or explain internal skill routing.
```
