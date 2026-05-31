# Engineering Architecture Review Checklists

Use these checklists selectively. They are prompts for investigation, not a requirement to report every item.

## Modularity Review Checklist

- Are module boundaries explicit and understandable from code, package structure, or documentation?
- Does each module have high cohesion around a clear responsibility?
- Are responsibilities misplaced across unrelated modules?
- Are dependencies directed inward toward stable domain concepts or outward toward volatile infrastructure?
- Are there cyclic dependencies between packages, modules, layers, or services?
- Are shared utilities becoming a dumping ground for domain logic?
- Are abstractions introduced only where they reduce coupling, improve testing, or isolate volatility?
- Can modules be tested independently without excessive mocking or full-system bootstrapping?
- Are internal implementation details leaking across boundaries?
- Is ownership clear enough for teams or maintainers to change the module safely?

## Architecture Review Checklist

- What is the system's main purpose and primary runtime flow?
- What are the major components, modules, services, jobs, and integrations?
- Which parts are stable, volatile, high-risk, or frequently changed?
- Where is architecture debt slowing delivery or increasing incident risk?
- Are core domain concepts represented clearly?
- Are responsibilities concentrated in large orchestration or god objects?
- Are business rules mixed with transport, persistence, UI, or infrastructure code?
- Are APIs and data models stable enough for consumers?
- Are configuration, secrets, and environment assumptions explicit?
- Are operational concerns designed in or bolted on inconsistently?
- Are architectural decisions documented where they affect future maintainers?

## Service Boundary Review Checklist

- Does each service or deployable have a clear purpose and ownership boundary?
- Is the boundary aligned with business capability, data ownership, or operational independence?
- Are services coupled through shared databases, internal tables, or undocumented assumptions?
- Are synchronous calls creating fragile chains or hidden availability dependencies?
- Are asynchronous contracts versioned and observable?
- Are API contracts explicit, validated, and backward-compatible where necessary?
- Are transaction boundaries clear across service calls and data stores?
- Are retries, idempotency, timeouts, and partial failure behavior defined?
- Could the same outcome be achieved with clearer modules instead of new services?
- Is the operational burden of each service justified?
- Would extracting a service reduce long-term complexity, or only move complexity into deployment and operations?
- Is independent deployment, scaling, ownership, or failure isolation valuable enough to justify a new service boundary?

## Organizational Review Checklist

- Is ownership clear for each major module, service, API, data model, and operational surface?
- Can one team safely modify the component without coordinating across many groups?
- Are cross-team dependencies slowing delivery or causing unclear accountability?
- Are architecture problems actually process, ownership, prioritization, or communication problems?
- Are responsibilities split in a way that matches how teams plan, build, deploy, and operate?
- Are operational responsibilities clear: alerts, runbooks, incidents, rollbacks, capacity, and support?
- Are shared components governed well enough to avoid becoming bottlenecks or dumping grounds?
- Does the architecture create handoffs that increase lead time or incident response time?
- Are domain boundaries and team boundaries aligned enough for safe change?
- Would a proposed architecture change increase coordination cost or reduce team autonomy?

## Performance Review Checklist

- Are CPU-heavy paths known, measured, and bounded?
- Is memory usage predictable under peak load, batch jobs, large payloads, or long-running processes?
- Are queues, streams, or job backlogs monitored for growth, age, throughput, and retry storms?
- Is network overhead significant across service, region, process, or dependency boundaries?
- Are database contention, locks, slow queries, indexes, connection pools, and transaction scopes understood?
- Are resource utilization and saturation visible for compute, memory, disk, network, database, and queues?
- Are capacity limits documented or inferable from load tests, production metrics, or configuration?
- Are caches used intentionally with clear invalidation and failure behavior?
- Are performance-sensitive code paths protected by benchmarks, load tests, or regression tests where appropriate?
- Would the proposed architecture change improve performance enough to justify added complexity?

## Migration Review Checklist

- Can the migration be incremental rather than a big-bang cutover?
- Can old and new paths coexist safely during rollout?
- Is rollback or roll-forward possible if correctness, performance, or reliability degrades?
- How will correctness be validated: tests, shadow reads, dual writes, reconciliation, checksums, audits, or sampled comparisons?
- What observability is required during migration: metrics, logs, traces, dashboards, alerts, migration progress, error budgets?
- Are data contracts, schemas, and API contracts backward-compatible during the transition?
- Are dual-write, backfill, replay, and idempotency risks understood?
- Are migration phases independently deployable and reversible where practical?
- Is the migration cost justified by reduced maintenance cost, improved reliability, or delivery speed?
- Has the team accounted for cleanup of old paths after migration?

## Evolution Cost Checklist

- What new operational burden will the change introduce?
- How much cognitive load does it add for development, debugging, testing, and onboarding?
- What is the migration cost and expected rollout duration?
- What maintenance cost should be expected over the next 1–3 years?
- Does the change reduce, move, or increase long-term complexity?
- Are there simpler modular changes that achieve most of the benefit?
- Does the change require new skills, tools, infrastructure, runbooks, or ownership models?
- Is the benefit measurable through reliability, delivery speed, performance, maintainability, or operational risk reduction?

## Observability Review Checklist

- Are logs structured and consistent enough to debug production behavior?
- Do logs include correlation/request IDs across boundaries?
- Are important business and technical events logged without exposing secrets or sensitive data?
- Are metrics available for latency, traffic, errors, saturation, queue depth, and resource usage?
- Are domain-specific metrics available for critical workflows?
- Are traces available for distributed or complex flows?
- Are health checks meaningful and separated for liveness/readiness where applicable?
- Are alerts tied to user impact, SLOs, or actionable symptoms?
- Are dashboards or runbooks available for common failure modes?
- Can operators answer: what changed, what is failing, who is impacted, and how to mitigate?

## Deployment Review Checklist

- Is the build and release process reproducible?
- Are environment-specific settings externalized and documented?
- Are secrets managed outside source code and logs?
- Are database migrations safe, reversible where possible, and compatible with rolling deploys?
- Is there a rollback or roll-forward strategy?
- Are resource requests, limits, autoscaling, and capacity assumptions defined where relevant?
- Are startup, shutdown, and graceful termination behaviors handled?
- Are smoke tests or post-deploy checks present?
- Are feature flags or staged rollout mechanisms available for risky changes?
- Are deployment dependencies and ordering constraints explicit?

## Reliability Review Checklist

- Are critical user journeys and failure modes identified?
- Are timeouts configured for external calls and slow operations?
- Are retries bounded, jittered, and safe for idempotency?
- Is backpressure handled for queues, streams, APIs, or worker pools?
- Are degraded modes or fallback behaviors defined for non-critical dependencies?
- Are errors classified and surfaced clearly to callers and operators?
- Are data consistency and recovery paths understood?
- Are single points of failure known and acceptable?
- Are scheduled jobs safe to rerun and observable?
- Are incident response, runbooks, and ownership paths clear enough?

## Testing Review Checklist

- Do tests cover important domain behavior rather than only implementation details?
- Are module boundaries supported by focused unit or component tests?
- Are integrations covered by integration or contract tests?
- Are API contracts tested for compatibility and error behavior?
- Are database migrations tested against realistic schemas or fixtures?
- Are critical user journeys covered by end-to-end or smoke tests where appropriate?
- Are failure modes tested: timeouts, retries, partial failures, invalid data, unavailable dependencies?
- Are tests deterministic and practical to run in CI?
- Do tests provide enough safety for refactoring?
- Are gaps tied to specific risks rather than reported generically?
