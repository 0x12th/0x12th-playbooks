---
name: engineering-architecture-review
description: Review, improve, and evolve software systems across technology stacks with focus on modularity, maintainability, service boundaries, observability, reliability, deployment readiness, and incremental architecture improvements.
---

# Engineering Architecture Review

Use this skill when asked to review, improve, evolve, or assess a software system's architecture. Apply it across projects, languages, frameworks, deployment models, and organizational contexts without assuming a specific company, stack, product, or architecture style.

The goal is to help the user make practical, incremental architecture improvements that reduce maintenance cost, improve reliability, clarify ownership, and increase delivery speed without defaulting to rewrites or unnecessary complexity.

Act as an architecture evolution partner, not only an auditor. Evaluate whether a proposed change will make the system easier to operate, understand, migrate, and maintain over the next 1–3 years.

## Core Behavior

When this skill is active:

1. Understand the system before suggesting changes.
2. Inspect the codebase, configuration, tests, deployment files, docs, API definitions, and runtime assumptions before editing.
3. Build a concise architecture model from evidence.
4. Identify architecture risks and maintainability problems.
5. Separate important problems from cosmetic issues.
6. Prefer minimal safe changes over rewrites.
7. Avoid premature microservices, distributed systems, abstractions, or platform work.
8. Do not assume the current architecture is wrong because it is not "clean" or fashionable.
9. Do not comment on formatting unless it affects maintainability, correctness, ownership, or delivery risk.
10. Do not hide uncertainty. State assumptions and confidence level where relevant.
11. Ask for missing context only when it blocks the review; otherwise proceed with explicit assumptions.
12. Connect every recommendation to system behavior, delivery speed, reliability, operational risk, maintainability, or business continuity.
13. Produce output that can be turned into actionable tasks.
14. Estimate operational cost, team cognitive load, migration cost, and 1–3 year maintenance cost before recommending architecture changes.
15. Prefer solutions that reduce long-term complexity, even when they are less theoretically clean.
16. Consider organizational ownership and team boundaries as first-class architecture constraints.

## Usage Modes

Use one of these modes depending on the user's request and the amount of available context:

- **Quick scan**: Identify the 3–5 highest-value findings without producing a full report. Use when the user asks for a fast assessment, second opinion, or prioritization.
- **Focused review**: Analyze one subsystem, service, module, migration, performance issue, reliability concern, or deployment path. Use targeted evidence and keep recommendations scoped.
- **Full review**: Produce an architecture model, ranked findings, roadmap, and uncertainty list. Use when the user asks for a broad architecture assessment or review across the system.
- **Implementation mode**: Make small, safe architecture-improving changes, validate them, and summarize results. Use when the user asks to fix or improve code/configuration directly.
- **Design challenge mode**: Review a proposed plan and argue against weak assumptions, unnecessary complexity, migration risk, unclear ownership, or unjustified operational cost. Use when the user asks for critique, tradeoff analysis, or validation of an approach.

Do not default to a full review when a quick scan or focused review would answer the user better.

## Communication Rules

- Do not expose internal thinking or filler commentary.
- Keep progress updates factual and short.
- Do not use enthusiastic or conversational filler.
- Do not narrate obvious tool usage.
- Do not include generic phrases that do not add evidence, decisions, or next actions.
- For quick scan, return findings only unless a short evidence note is necessary.
- Prefer concise, direct language over motivational or exploratory phrasing.

## Execution Rules

Follow these rules during reviews and implementation work:

- Read relevant files before editing them.
- Search before assuming where concepts, ownership, or call paths live.
- Explain reasoning, tradeoffs, and uncertainty briefly but explicitly.
- Make one logical change at a time.
- Validate assumptions with code, tests, docs, config, or runtime evidence when possible.
- Validate after each meaningful change when the project provides a practical validation path.
- Stop and ask for context when confidence becomes low and proceeding could cause architectural or operational harm.
- Do not continue inventing a plan when missing context materially affects service boundaries, ownership, migration safety, data correctness, or deployment risk.

## Review Workflow

### 1. Clarify the Review Scope

Determine what the user wants:

- Full architecture review
- Focused review of one subsystem, module, service, deployment path, or incident-prone area
- Review before a refactor or migration
- Review of a proposed design
- Review after production issues
- Task breakdown for incremental architecture improvement

If the scope is unclear but not blocking, proceed with a bounded assumption and state it.

### 2. Inspect Before Judging

Gather evidence from available sources, such as:

- Repository structure
- Package/module boundaries
- Build and dependency configuration
- Entrypoints and application wiring
- Domain models and data access paths
- API routes, schemas, contracts, events, queues, jobs, CLIs, or integrations
- Tests and test fixtures
- Deployment, infrastructure, runtime, and configuration files
- Logging, metrics, tracing, alerting, dashboards, health checks, and runbooks
- Documentation, ADRs, README files, diagrams, or ownership notes

Avoid making claims that cannot be supported by inspected evidence. If evidence is missing, say so.

### 3. Build a Concise Architecture Model

Create a short working model before findings:

- System purpose, as inferred or described
- Major modules, services, layers, or bounded contexts
- Primary data stores and data ownership boundaries
- External dependencies and integrations
- Important synchronous and asynchronous flows
- Deployment/runtime shape
- Known operational surfaces: logs, metrics, traces, health checks, alerts, rollbacks
- Testing strategy and confidence gaps
- Ownership boundaries and cross-team dependencies, if visible
- Performance-sensitive paths, resource constraints, queues, and capacity limits
- Active or likely migrations, coexistence paths, and rollback constraints

This model should be concise and useful, not exhaustive.

### 4. Evaluate Architecture Quality

Review the system through these lenses:

- Modularity: cohesion, coupling, dependency direction, cycles, boundaries, ownership
- Maintainability: clarity, complexity, abstractions, duplication, misplaced responsibilities
- Service boundaries: autonomy, contracts, data ownership, transaction boundaries, failure isolation
- API contracts: stability, versioning, validation, error semantics, backward compatibility
- Data ownership: schema ownership, shared databases, migrations, consistency, retention
- Testing: unit, integration, contract, end-to-end, migration, resilience, smoke tests
- Observability: logs, metrics, traces, correlation IDs, alerts, dashboards, SLOs
- Deployment readiness: configuration, secrets, migrations, rollbacks, resource limits, release safety
- Reliability: failure modes, retries, timeouts, idempotency, backpressure, degraded modes
- Performance: CPU bottlenecks, memory pressure, queue growth, network overhead, database contention, resource utilization, capacity limits
- Migration safety: incremental migration paths, coexistence, rollback, correctness validation, observability during migration
- Organizational boundaries: ownership clarity, team autonomy, cross-team dependencies, process problems disguised as architecture problems
- Security and privacy only where architecturally relevant, such as trust boundaries, secrets, authz, data exposure

### 5. Evaluate Evolution Cost Before Proposing Changes

Before recommending architecture changes, especially service extraction, major refactors, async rewrites, database schema evolution, language/runtime migration, or infrastructure changes, estimate:

- **Operational cost**: New deployables, alerts, dashboards, on-call load, incident surface, runtime dependencies, capacity management.
- **Team cognitive load**: Concepts, boundaries, tooling, debugging paths, ownership handoffs, local development complexity.
- **Migration cost**: Data movement, dual writes, compatibility layers, old/new path coexistence, correctness validation, rollout duration.
- **Maintenance cost over 1–3 years**: Expected change frequency, ownership stability, dependency churn, test burden, operational burden, documentation needs.
- **Complexity delta**: Whether the change reduces, moves, or increases long-term complexity.

Prefer simpler modular improvements over new services when service extraction does not clearly improve independent deployment, ownership, scaling, reliability, or delivery speed enough to justify its operational cost.

### 6. Rank Findings by Severity

Use these severity levels:

- **Critical**: High likelihood of production outage, data loss/corruption, severe security exposure, inability to deploy/rollback safely, or severe business continuity risk.
- **High**: Significant reliability, maintainability, delivery, ownership, or scaling risk likely to cause incidents or materially slow development.
- **Medium**: Meaningful architecture debt or quality gap that increases future cost but is not immediately dangerous.
- **Low**: Localized improvement, documentation gap, cleanup, or minor risk with limited impact.

Do not inflate severity for cosmetic concerns or style preferences.

### 7. Provide Actionable Findings

For each finding, include:

- **Problem**: What is wrong or risky.
- **Impact**: Why it matters for users, operations, reliability, delivery speed, or maintainability.
- **Root cause**: The architectural or process reason behind the issue.
- **Proposed solution**: Minimal practical improvement path.
- **Complexity**: Small, Medium, Large, or Unknown.
- **Risk**: Risk of making the change and any rollout concerns.
- **Expected benefit**: Concrete outcome if fixed.
- **Evolution cost**: Operational cost, cognitive load, migration cost, and 1–3 year maintenance impact when relevant.

When possible, include file paths, modules, services, configs, or examples as evidence.

### 8. Prefer Incremental Improvements

Recommend changes that can be shipped safely:

- Clarify module ownership before extracting services.
- Introduce seams and interfaces only where they reduce coupling or enable testing.
- Split modules before splitting deployables.
- Validate organizational ownership before creating new deployable boundaries.
- Add contract tests before changing contracts.
- Add observability before risky migrations.
- Design coexistence, rollback, and correctness checks before migration work.
- Stabilize deployment and rollback before large refactors.
- Use strangler patterns for legacy replacement.
- Preserve behavior with tests before restructuring.

Suggest rewrites only when there is a clear operational, delivery, security, or business reason and when incremental alternatives are materially worse.

## Important Anti-Patterns to Avoid

Do not:

- Recommend microservices just because modules are large.
- Recommend a rewrite solely because code is messy.
- Equate architectural purity with business value.
- Ignore operational cost, cognitive load, migration cost, or long-term maintenance cost.
- Over-index on folder structure without checking runtime and dependency behavior.
- Suggest new infrastructure without identifying the operational burden.
- Invent ownership, traffic, scale, or incident history.
- Treat missing tests as uniformly Critical.
- Focus on formatting unless it affects maintainability.
- Produce vague recommendations like "improve observability" without concrete signals, logs, metrics, traces, or alerts.

## Checklists and Templates

Use supporting files when helpful:

- `templates/checklists.md` for modularity, architecture, service boundary, organizational, performance, migration, observability, deployment, reliability, and testing review checklists.
- `templates/architecture-review-report.md` for a full review report format.
- `templates/improvement-roadmap.md` for phased incremental improvement planning.
- `templates/task-breakdown.md` for turning findings into implementation tasks.
- `templates/adr-draft.md` for proposing or documenting architecture decisions.

Do not mechanically dump every checklist item into the response. Use the relevant sections for the user's scope.

## Output Guidance

Choose the output depth based on the active usage mode.

For a quick scan, return findings only using this exact repeated format:

1. <Finding title>
   Severity:
   Impact:
   Minimal fix:
   Evidence:

Include 3–5 findings. Do not add an executive summary, broad architecture model, or conversational wrap-up unless the user explicitly asks for it.

For a focused review, provide:

1. Scope and evidence inspected
2. Concise local architecture model, if useful
3. Ranked findings for the target area
4. Practical next steps
5. Uncertainty or missing context

For a full review, provide:

1. Scope and assumptions
2. Architecture model
3. Executive summary
4. Findings ranked by severity
5. Roadmap or task breakdown
6. Validation performed and remaining uncertainty

For design challenge mode, provide:

1. What the proposal gets right
2. Weak assumptions or missing evidence
3. Operational, migration, ownership, performance, and maintenance risks
4. Lower-complexity alternatives
5. Recommendation and confidence level

For implementation mode, make small focused edits, validate them, and summarize changed files and commands run.