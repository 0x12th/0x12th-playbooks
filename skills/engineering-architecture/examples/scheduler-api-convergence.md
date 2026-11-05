# Example: scheduler API shape without domain redesign

## Established context

A scheduler already supports one-off jobs via `run_at` and recurring jobs via `cron` plus `timezone`. Both use the same delivery and run-history machinery. The user wants both capabilities, dislikes a flat request DTO with mutually exclusive fields, and is only collecting proposed changes in a backlog. A client-supplied UUID for task identity/idempotency has already been agreed in principle.

## Follow-up

User: "I don't like this hybrid API. Should we split tasks and schedules? Won't that duplicate endpoints?"

## Good response

"Both job types are supported today and share almost all management operations. Splitting them into separate resources would duplicate much of the public API. I would keep one task resource and the shared execution machinery. If the concern is invalid combinations of schedule fields, make the input contract explicit with two validated schedule variants and document them in OpenAPI. That is a contract-level option, not a reason to change task lifecycle. Keep the resource split as an open alternative only if a concrete client requirement calls for different operations. No code changes yet; record the confirmed UUID decision and the unresolved request-schema choice in the backlog."

## Bad response

"One-off tasks must become immutable after their first run, while schedules can be resumed. Therefore introduce separate /tasks and /schedules APIs."

Why bad: the lifecycle restriction was not requested or established by code. It invents a requirement to justify an API split, expands scope, and reopens a question already narrowed by evidence.

## Expected checks

- Preserve one-off and recurring scheduling capabilities.
- Do not claim one-off means one execution for the entire lifetime of a task unless specified.
- Compare contract-level fixes before new resources.
- Distinguish confirmed backlog decisions from open design questions.
- Converge once the evidence answers the user's question.
