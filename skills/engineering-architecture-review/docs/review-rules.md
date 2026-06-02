# Review Rules

Use these rules for quick scan, focused review, and full review.

## Core Review Behavior

- Understand the system before recommending changes.
- Build a concise architecture model from evidence when the mode requires it.
- Separate important problems from cosmetic issues.
- Connect every finding to system behavior, delivery speed, reliability, operational risk, maintainability, ownership, or business continuity.
- Do not comment on formatting unless it affects maintainability, correctness, ownership, or delivery risk.
- Do not invent ownership, traffic, scale, incident history, or business constraints.

## Architecture Lenses

Evaluate only the lenses relevant to the request:

- Modularity: cohesion, coupling, dependency direction, cycles, boundaries, ownership
- Maintainability: complexity, abstractions, duplication, misplaced responsibilities
- Service boundaries: autonomy, contracts, data ownership, transaction boundaries, failure isolation
- API contracts: stability, versioning, validation, errors, backward compatibility
- Data ownership: schema ownership, shared databases, migrations, consistency, retention
- Testing: unit, integration, contract, end-to-end, migration, resilience, smoke tests
- Observability: logs, metrics, traces, correlation IDs, alerts, dashboards, SLOs
- Deployment readiness: configuration, secrets, migrations, rollbacks, release safety
- Reliability: retries, timeouts, idempotency, backpressure, degraded modes
- Performance: CPU, memory, queues, network, database contention, resource utilization
- Migration safety: coexistence, rollback, correctness validation, observability
- Organizational boundaries: ownership clarity, team autonomy, cross-team dependencies

## Severity

- **Critical:** high likelihood of production outage, data loss/corruption, severe security exposure, inability to deploy/rollback safely, or severe business continuity risk.
- **High:** significant reliability, maintainability, delivery, ownership, or scaling risk likely to cause incidents or materially slow development.
- **Medium:** meaningful architecture debt or quality gap that increases future cost but is not immediately dangerous.
- **Low:** localized improvement, documentation gap, cleanup, or minor risk with limited impact.

Do not inflate severity for cosmetic concerns or style preferences.

## Priority

Do not prioritize solely by severity. Consider:

- Severity
- Cost to fix
- Risk to fix
- Expected benefit
- Time to realize benefit

Distinguish severity from what should be worked on next.

## Finding Quality

Each finding should include:

- Problem
- Impact
- Evidence
- Root cause where useful
- Minimal practical solution
- Complexity
- Risk
- Expected benefit
- Evolution cost when relevant

Prefer fewer findings with stronger evidence over a larger speculative list.

## Output by Mode

Quick scan:

- 3-5 findings only.
- No executive summary.
- No broad architecture model.
- Use the format from `communication-rules.md`.

Focused review:

1. Scope
2. Concise local architecture model, if useful
3. Ranked findings for the target area
4. Practical next steps
5. Uncertainty or missing context

Full review:

1. Scope and assumptions
2. Architecture model
3. Executive summary
4. Findings ranked by severity
5. Roadmap or task breakdown
6. Validation performed and remaining uncertainty
