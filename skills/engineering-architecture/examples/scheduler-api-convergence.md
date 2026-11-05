# Example: scheduler API shape without domain redesign

## Established context

A scheduler already supports one-off jobs via `run_at` and recurring jobs via `cron` plus `timezone`. Both use the same delivery and run-history machinery. The user wants both capabilities, dislikes a flat request DTO with mutually exclusive fields, and is only collecting proposed changes in a backlog. A client-supplied UUID for task identity/idempotency has already been agreed in principle.

## Follow-up

User: "I don't like this hybrid API. Should we split tasks and schedules? Won't that duplicate endpoints?"

## Good response

**Verdict: Keep one task resource; consider a contract-level change before separate resources.**

You want a clearer request shape while preserving one-off and recurring scheduling, shared delivery/history, and backlog-only scope.

- **Next safe step — request-schema proposal; confidence: medium.** Compared with the current flat DTO, two validated schedule variants documented in OpenAPI could reject invalid field combinations without changing task identity or lifecycle. Check accepted one-off and recurring payloads and rejected mixed-field payloads. The main risk is client compatibility; the exact schema is still an open choice.
- **Defer pending evidence — separate resources; confidence: high.** Shared delivery/history alone does not prove identical management lifecycles, but no requirement for different operations has been established either. A split adds public API surface and may duplicate management endpoints. Reconsider it if a concrete client scenario requires independent resource management; validate the split against that scenario before changing the contract. The main risk is migration cost without a confirmed benefit.

Backlog: retain the agreed client-supplied UUID decision, keep the request-schema choice open, and defer the resource split. No implementation or active-contract changes.

## Bad response

"One-off tasks must become immutable after their first run, while schedules can be resumed. Therefore introduce separate /tasks and /schedules APIs."

Why bad: the lifecycle restriction was not requested or established by code. It invents a requirement to justify an API split, expands scope, and reopens a question already narrowed by evidence.

## Expected checks

- Lead with a verdict, then restate the goal and current behavior; include confidence and technical disposition for significant recommendations.
- Preserve one-off and recurring scheduling capabilities.
- Do not claim one-off means one execution for the entire lifetime of a task unless specified.
- Compare contract-level fixes before new resources.
- Distinguish confirmed backlog decisions from open design questions.
- Converge once the evidence answers the user's question; reconsider when a new requirement or material evidence changes the tradeoff.
