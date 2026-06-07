# Anti-Overengineering Rules

Architecture work should reduce real cost, not create architectural theater.

Prefer:

- Deletion over abstraction.
- Consolidation over service extraction.
- Local improvement over redesign.
- Evidence over architectural fashion.
- Explicit ownership over generic layering.
- Stable module boundaries over new deployables.
- Behavior-preserving evolution over rewrites.
- Instrumentation before risky migration.
- Contract tests before contract changes.
- Smaller reversible steps over large irreversible moves.

Do not recommend:

- Microservices because modules are large.
- Rewrites because code is messy.
- New infrastructure without operational justification.
- New abstractions without repeated volatility or testing pressure.
- Service extraction without clear independent deployment, ownership, scaling, reliability, compliance, or team-autonomy benefit.
- Event-driven architecture when synchronous flow is simpler and adequate.
- A migration when current pain is not material.

## Anti-Futurism

Do not design services, brokers, adapters, layers, or platform components that the current problem does not require.

Do not propose new services, brokers, adapters, or platform components when the current problem can be solved:

- Inside an existing service.
- By changing module boundaries.
- By consolidating responsibility.
- By simplifying interactions.
- By improving contracts, ownership, tests, observability, or deployment safety inside the current shape.

Any new service, broker, adapter, runtime, or platform component must be explicitly justified by material current pain and expected benefit that outweighs migration, operational, and cognitive cost.

Before recommending a structural change, compare:

1. Current state / do nothing.
2. Minimal local improvement.
3. Proposed change.

If the minimal local improvement captures most of the benefit with lower cost and risk, prefer it.

Architectural correctness is not enough. The change must improve maintainability, reliability, delivery speed, operational safety, ownership, compliance, performance, or business continuity enough to justify its cost.
