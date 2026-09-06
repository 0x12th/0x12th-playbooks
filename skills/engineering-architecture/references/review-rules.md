# Review Rules

Use these rules for quick scan, focused review, and full review.

## Core Review Behavior

- Understand the system before recommending changes.
- Build a concise architecture model from evidence when the mode requires it.
- When Technical Evolution is selected, include current architecture state, technical constraints, options compared, recommended next safe architecture step, and validation or rollback requirements.
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
- Production readiness: environment configuration, secrets, dependency services, persistence, backups, restore path, migrations, smoke tests, release gates, rollback, monitoring, alerting, incident response, and operator runbooks
- Deployment readiness: build artifacts, deployment path, configuration, secrets, migrations, rollbacks, release safety, health checks, smoke tests, and release verification
- Release/update readiness: compatibility, migrations, data safety, rollback, versioning, cache invalidation, dependency changes, and user-facing risk
- Operational readiness: logs, metrics, traces, dashboards, alerts, on-call usability, failure modes, degraded operation, recovery steps, and runbooks
- Runtime resource fit: CPU, memory, disk, network, database capacity, queue depth, concurrency, process model, background jobs, storage growth, backup cost, and resource contention
- VPS/server fit: whether the current runtime, database, background work, storage, backup, monitoring, and traffic assumptions fit the proposed server without hidden operational risk
- Capacity and scaling: current bottlenecks, vertical scaling headroom, horizontal scaling constraints, stateful components, database contention, cache pressure, queue throughput, and cost of growth
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

Follow the `SKILL.md` result contract in every mode: verdict first, confidence
and technical disposition for each significant recommendation, and only useful
sections. The mode-specific details below do not replace that contract.

Quick scan:

- Direct verdict first.
- Up to five supported findings, fewer or none when evidence warrants; never explore or invent issues to fill a quota.
- No executive summary.
- No broad architecture model.
- Keep findings concise with impact, evidence, minimal action, confidence and technical disposition; omit empty sections.

Focused review:

1. Verdict
2. Scope
3. Concise local architecture model, if useful
4. Ranked findings for the target area
5. Practical next steps
6. Uncertainty or missing context

Full review:

1. Verdict
2. Scope, selected repository, assumptions, and evidence inspected
3. Current architecture model: major components, responsibilities, key dependencies, runtime/deployment shape, and critical flows
4. Strengths and constraints
5. Findings ranked by severity and practical priority
6. Technical evolution or deployment readiness analysis when relevant: constraints, options, readiness verdict, target architecture or explicit "no target change needed"
7. Next safe steps with validation, rollback or mitigation, and observability signals
8. Remaining uncertainty and missing evidence
