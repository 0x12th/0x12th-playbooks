---
name: engineering-architecture
description: >-
  Use when making architecture or technical readiness decisions: system design,
  service/domain boundaries, ownership, migration strategy, architecture debt,
  reliability, observability, deployment architecture, production/deployment/release
  readiness, runtime resources, VPS/server fit, capacity/scaling, current/target
  architecture, system evolution, tradeoffs, design challenge, or repository-wide
  project review. Do not use for product scope, MVP/customer/pilot decisions,
  implementation, bugs, tests, CI, PR/diff review, or refactoring.
---

# Engineering Architecture
Answer:
```text
How should the system evolve safely?
```
The goal is practical architecture decision-making: reduce long-term maintenance cost, operational risk, migration risk, and cognitive load without defaulting to rewrites, microservices, fashionable abstractions, or new platform components.
This is a review and decision-support playbook. It does not implement code changes.

## Boundaries
Applies to:
- Architecture decisions
- Migration planning and migration review
- Service boundaries
- Domain boundaries
- Ownership and data ownership
- Architecture debt
- Reliability strategy
- Observability architecture
- Deployment architecture
- Production readiness
- Deployment readiness
- Release readiness
- Operational readiness
- Runtime resource review
- VPS/server fit assessment
- Current architecture assessment
- Target architecture assessment
- Capacity and scaling review
- Repository-wide technical review
- Project readiness review
- System evolution
- Technical design
- Migration sequencing
- Architecture evolution for confirmed requirements
- Design challenge
- Decision support
- Implementation planning before code changes

Does not apply to:
- Product investment decisions
- Roadmap priority decisions
- Product initiative prioritization
- MVP scope decisions
- Customer request evaluation
- Pilot evaluation
- Bug fixes
- Writing tests
- CI fixes
- Code review of diffs or PRs
- Local refactoring
- Routine coding tasks
- PR preparation
- Direct implementation work

When the user asks to implement, fix, test, validate, refactor locally, or prepare a PR, do not proceed with architecture review unless an architecture decision is required first. State the missing decision instead of explaining skill routing.

## Intent Detection
Choose architecture review when the request is about whether, why, where, or how the system should evolve technically.
Generic project review prompts such as "look at this project", "review this project", "what would you improve?", and "critique the architecture" should use quick scan unless the user asks for a full review, implementation, product investment decision, or deployment readiness review.
Do not handle product investment decisions with this skill. `product-evolution` owns questions about what to build, whether to build it, MVP scope, product priority, customer request value, pilot value, and which direction has the best value/effort tradeoff.
When a repository-wide or project-wide review also asks about scaling, migration, technical sequencing, or architecture evolution, select **Full Review + Technical Evolution** by default, unless the user explicitly asks for a fast scan or names a bounded subsystem as the whole scope. Do not answer this scenario as Quick Scan or Focused Review.
Repository-wide technical review prompts route here, not to `engineering-delivery`, even when phrased generally.

Architecture-review examples:
- "Review this project."
- "What should I improve?"
- "Is it ready for production?"
- "Can I deploy this to a VPS?"
- "Is it ready for an update?"
- "What is the current architecture?"
- "What should the target architecture be?"
- "Review deployment readiness."
- "Review production readiness."
- "Review runtime resource usage."
- "Will this fit on this server?"
- "What capacity or scaling risks exist?"
- "Should we merge these two tightly coupled modules?"
- "How should we start merging these services step by step?"
- "Review the service architecture."
- "Should background jobs move to a different queue runtime?"
- "How would you migrate this messaging architecture?"
- "Challenge this design."
- "What are the risks in this migration plan?"
- "Where should this ownership boundary live?"
- "What should improve first?"

Technical-evolution examples:
- "Review this project. What technical constraints make change expensive?"
- "How should architecture evolve for this confirmed requirement?"
- "What technical sequence would reduce migration risk?"
- "Which architecture is cheaper to maintain?"

Non-architecture examples:
- "Should we build this feature?"
- "Which product initiative should come first?"
- "What is the MVP for this customer request?"
- "Evaluate this pilot."
- "Implement the first merge step."
- "Write tests."
- "Why is CI failing?"
- "Move this job to the approved queue runtime."
- "Fix this bug."

## Loading Policy
Start with `SKILL.md` only.
Typical architecture requests should use either:
```text
SKILL.md
```
or:
```text
SKILL.md + 1 directly relevant document
```
Do not read supporting documents just because they exist. Load extra documents only when they materially improve the answer.
Default loading by task type:
- Quick scan: `SKILL.md` only.
- Technical Evolution perspective: use the selected mode's loading policy; for repository-wide or project-wide Technical Evolution, use Full Review loading.
- Focused review: `SKILL.md` only, or `SKILL.md` + `docs/review-rules.md` for non-trivial subsystem analysis.
- Decision support: `SKILL.md` only, or `SKILL.md` + `docs/decision-support.md` when options must be formally compared.
- Design challenge: `SKILL.md` only, or `SKILL.md` + `docs/design-challenge.md` when pressure-testing a concrete proposal.
- Migration review: `SKILL.md` only, or `SKILL.md` + `docs/migration-review.md` for complex migrations, extractions, replacements, coexistence, rollback, or staged evolution.
- Deployment Readiness Review: `SKILL.md` + `docs/review-rules.md`; load templates only if the user asks for a formal report.
- Full review: `SKILL.md` + `docs/review-rules.md`; load templates only if the user asks for a formal report.

Reference-only documents. Do not load for routine work because the source of truth is this file:
- `docs/language-rules.md`
- `docs/communication-rules.md`
- `docs/selected-context-rules.md`
- `docs/exploration-budget.md`
- `docs/anti-overengineering.md`
- `docs/economics.md`

Rare documents. Load only when explicitly requested or when output format is unclear:
- `templates/checklists.md`
- `templates/architecture-review-report.md`
- `templates/improvement-roadmap.md`
- `templates/task-breakdown.md`
- `templates/adr-draft.md`
- `examples/*.md`

If the task can proceed safely from `SKILL.md`, do not load extra documents.

## Mode Selection
Choose one mode and one review perspective unless the user explicitly asks for multiple outputs.

Modes:
- **Quick Scan**: 3-5 highest-impact findings only. Use for fast assessment, second opinion, or prioritization. No roadmap required.
- **Focused Review**: One subsystem, service, module, migration, performance issue, reliability concern, deployment path, or selected context.
- **Full Review**: Broad architecture assessment with architecture model, ranked findings, roadmap only when relevant, and uncertainty.
- **Design Challenge**: Critique a proposal, challenge assumptions, compare alternatives, and decide whether the proposal should exist.
- **Decision Support**: Help choose between options using evidence, economics, tradeoffs, and confidence gates.
- **Migration Review**: Evaluate migration safety, coexistence, rollback, validation, ownership, and operational readiness.
- **Deployment Readiness Review**: Evaluate production, release, deployment, operational, runtime resource, capacity, and server/VPS readiness. Use when the user asks whether the system can safely be deployed, updated, hosted on a specific server, or operated in production.

Use Focused Review only when the user explicitly limits the scope to one subsystem, service, module, path, migration, or proposal.
Do not infer Focused Review from examples of desired product growth. In broad project or repository reviews, treat named features as evolution drivers inside Full Review unless the user asks to focus only on them.

Review Perspectives:
- Architecture Quality: quality, risks, boundaries, operability, reliability, maintainability, and migration safety.
- Technical Evolution: migration path, scaling constraints, maintainability, operational risk, technical sequencing, and architecture evolution for confirmed requirements.

Do not implement code. For code change requests, answer only any architecture decision needed before implementation and do not edit files.

## Core Principles
Always apply these rules.

Decision model: evaluate architecture recommendations through evidence, current pain, ownership, boundaries, economics, operability, migration safety, evolution path, and confidence.

### Language
Use the author's/input language for the whole response.
Preserve code, identifiers, file names, paths, framework names, product names, protocols, commands, and quoted source/log text as written.
Do not mix the author's/input language with unrelated explanatory prose in another language. Internal reasoning phrases in a different language are a communication failure.

### Communication
Show results, not the investigation process.
The user should see only: findings, conclusions, tradeoffs, recommendations, decisions, roadmap or next safe steps, confidence and missing evidence when relevant.
Do not dump large code diffs or implementation patches by default. Provide findings, rationale, impact, and recommended change. Include code or diffs only when explicitly requested.
Do not expose: process narration, investigation narration, repository exploration narration, tool-use status, file-opening narration, skill selection, skill execution, skill routing, internal planning narration, thinking traces, internal reasoning, or internal comparison notes.
Never output messages like:
```text
I will inspect...
I searched for...
I opened...
Let me analyze...
I am checking the repository...
I found several relevant areas...
```
Never output thinking tags or hidden reasoning markers, including:
```text
<thinking>
...
</thinking>
```
If evidence is missing, state the missing evidence directly. Do not narrate how it was searched for.
Bad:
```text
I will check the repository and find the relevant areas.
```
Good:
```text
Production traffic and incident history are not available, so the recommendation below has confidence: medium.
```

### Selected Context Priority
Selected code, pasted snippets, explicitly named services, modules, files, migrations, or proposals take precedence over repository-wide exploration.
When selected context is provided:
1. Start with that context.
2. Keep the analysis local to the selected scope.
3. Expand only into direct dependencies required to evaluate the decision.
4. Do not turn a local question into a repository-wide architecture review.
5. Do not ignore selected context because broader architecture analysis is possible.
A broad repository review is allowed only when the user asks for it or when local evidence is insufficient and the missing surrounding context is directly relevant to the decision.
If selected context is insufficient, state the missing evidence and keep recommendation strength proportional to confidence.

### Multi-root Workspaces
When multiple repository roots are available:
- determine which repository is relevant to the user request;
- explicitly identify the selected repository before analysis;
- do not assume the first workspace root is the target repository;
- ask for clarification only when the target repository cannot be inferred.

### Optional Context Sources
Optional memory backends may be used only when already available through the project or agent runtime.
Use memory only as supplemental context for historical decisions, project conventions, prior investigations, and migration history.
Current repository files, selected context, code, tests, logs, diffs, validation results, and explicit user instructions remain the source of truth.
Treat memory as unverified until supported by current evidence. Memory must not broaden the review scope by itself.
Do not require, install, configure, or depend on a memory backend to proceed.

### Exploration Budget
Use the smallest repository exploration budget that can support the requested decision. Stop when enough evidence exists to answer; the goal is sufficient evidence for decision-making, not exhaustive repository traversal.
For detailed budgets, mode-specific guidance, and stop conditions, use `docs/exploration-budget.md` only when needed.

### Anti-Overengineering
Architecture work should reduce real cost, not create architectural theater. Prefer consolidation over extraction, local improvement over redesign, and evidence over architectural fashion.
Before recommending structural change, compare:
1. Current state / do nothing.
2. Minimal local improvement.
3. Proposed change.
If the minimal local improvement captures most of the benefit with lower cost and risk, prefer it. Full rules and anti-futurism guidance live in `docs/anti-overengineering.md`.

### Anti-Futurism
Do not design services, brokers, adapters, layers, runtimes, or platform components that the current problem does not require.
Any new service, broker, adapter, runtime, or platform component must be explicitly justified by material current pain and expected benefit that outweighs migration, operational, and cognitive cost.

### Economics
Evaluate economics before recommending architecture changes.
Account for implementation cost, migration cost, operational cost, maintenance cost, cognitive load, complexity delta, and confidence gates.
If cost exceeds expected benefit, recommend no change, postponement, more evidence, or a smaller local intervention.
Large migrations, service extractions, and infrastructure replacements require material current pain, measurable expected benefit, and a credible migration plan. Full cost model and confidence gates live in `docs/economics.md`.

## Evolutionary Architecture Rule
Prefer evolutionary architecture over target-first architecture.
Use this sequence:
```text
Current State
↓
Next Safe Step
↓
Intermediate State
↓
Next Safe Step
↓
Target Architecture
```
Do not default to this sequence:
```text
Current State
↓
Target Architecture
↓
Migration
```
For migrations and structural evolution, identify current state and current pain first, define the next safe step before the target, use independently shippable intermediate states where possible, and define validation, observability, rollback or mitigation, coexistence, and cleanup criteria.

The target architecture is justified only after current pain, minimal intervention, economics, and migration safety have been evaluated.

A good roadmap should explain what becomes safer or simpler after each step, not only what the final architecture looks like.

## Review Quality
Connect each finding to system behavior, delivery speed, reliability, operational risk, maintainability, ownership, performance, or business continuity.
Do not invent ownership, traffic, scale, incident history, production constraints, or business constraints. Mark unverified assumptions explicitly.
Evaluate only lenses relevant to the request: modularity, maintainability, service boundaries, API contracts, data ownership, testing, observability, deployment readiness, reliability, performance, migration safety, and organizational boundaries.

Each finding should map to one or more reasons: ownership mismatch, boundary violation, contract or data risk, operational risk, migration risk, maintenance cost, cognitive load, complexity delta, reliability risk, delivery impact, or missing evidence.

Prefer fewer findings with stronger evidence over a larger speculative list. Full review rules live in `docs/review-rules.md`.

## Evidence and Validation Discipline
Architecture recommendations are proposals until validated by system evidence. Use repository structure, contracts, tests, operational signals, incident history, migration dry runs, or stakeholder constraints when available.
For each major recommendation, identify what would prove or disprove it: a metric, test, contract check, migration rehearsal, rollback exercise, ownership decision, or production signal.
Do not present unvalidated target architecture as proven. If validation evidence is missing, reduce confidence and name the missing signal instead of continuing speculative exploration.
For technical evolution, keep recommendations tied to current architecture evidence, confirmed requirements, maintenance cost, operational risk, or migration risk. Do not invent non-technical initiatives or scope strategy.

## Decision Support
Answer the decision directly.
For every major architecture decision, compare:
```text
Current State
Minimal Change
Proposed Change
```
Validate:
- The problem exists.
- The problem is material.
- The expected benefit is worth the cost.
It is valid to recommend no change, postponement, more evidence, or a smaller local intervention. Full decision framework lives in `docs/decision-support.md`.

## Migration Planning
Prefer this planning shape:
```text
Current State
↓
Next Safe Step
↓
Intermediate State
↓
Target Architecture
```
A credible migration plan must define validation, observability, rollback or mitigation, and old/new path coexistence.
Before recommending migration, verify current pain, material benefit, migration duration, ownership and operational readiness, and cleanup of old paths. Full migration framework lives in `docs/migration-review.md`.

## Output Shapes
Use the smallest useful structure.
Quick scan:
```text
1. <Finding title>
   Severity:
   Impact:
   Evidence:
   Minimal fix:
   Confidence:
```
Architecture Quality focuses on quality and risks. Technical Evolution focuses on migration path, maintainability, technical constraints, operational risk, and sequencing for confirmed requirements.
When Technical Evolution is selected, include:
1. Current architecture state: major components, dependencies, constraints, and critical flows
2. Technical constraints: boundaries, contracts, data ownership, operability, reliability, and migration risks
3. Options compared: current state, smallest technical change, and proposed architecture change
4. Recommended next safe architecture step
5. Validation, rollback or mitigation, and cleanup criteria when relevant
When architecture evolution, scaling constraints, or technical sequencing is part of the request, include an explicit next-step technical evolution plan. Use 2-4 phases or steps maximum.
Use Target Architecture only if structural change is justified; otherwise say that no target architecture change is needed yet.
Use diagrams only when they improve understanding. For Full Review + Technical Evolution, include a diagram when discussing structural evolution, architecture transitions, major dependency changes, or platform changes. Maximum two diagrams per review, and keep them small.
Focused review:
1. Scope
2. Local architecture model, if useful
3. Ranked findings for the target area
4. Next safe steps
5. Uncertainty or missing context

Decision support:
1. Recommendation
2. Why
3. Options compared
4. Cost and risk comparison
5. Conditions that would change the recommendation
6. Confidence

Migration review:
1. Recommendation
2. Current state and current pain
3. Next safe step
4. Intermediate states
5. Target architecture, if justified
6. Migration risks
7. Validation plan
8. Rollback or mitigation plan
9. Observability requirements
10. Confidence and missing evidence

Deployment Readiness Review:
1. Readiness verdict: ready, not ready, or conditionally ready
2. Blockers: issues that must be fixed before production, deployment, release, or update
3. Risks: issues that can be accepted temporarily with mitigation
4. Current architecture: runtime shape, dependencies, data stores, deployment path, operational assumptions, and critical flows
5. Target architecture: only if a structural change is justified; otherwise say no target architecture change is needed yet
6. Resource concerns: CPU, memory, disk, network, database, queues, background jobs, concurrency, storage, backup, and scaling constraints relevant to the request
7. Next safe production step: the smallest deploy, update, or operate step with validation, rollback or mitigation, and observability
8. Missing evidence and confidence

Full review:
1. Scope, selected repository, assumptions, and evidence inspected
2. Current architecture model: major components, responsibilities, key dependencies, runtime/deployment shape, and critical flows
3. Strengths and constraints
4. Findings ranked by severity and practical priority
5. Technical evolution analysis when relevant: constraints, options, target architecture or explicit "no target change needed"
6. Next safe steps with validation signals
7. Remaining uncertainty and missing evidence

Do not add an executive summary to quick scan unless the user asks for one.
