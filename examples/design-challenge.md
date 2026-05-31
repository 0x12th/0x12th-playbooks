# Example: Design Challenge Mode

Prompt:

```text
Challenge this proposal: split the monolith into separate services for billing, notifications, and reporting. Focus on operational cost, migration risk, ownership, and long-term maintenance.
```

Example output:

```md
## What the proposal gets right

- Billing, notifications, and reporting likely have different change rates and reliability needs.
- Clearer boundaries could reduce accidental coupling if the current modules are tightly intertwined.
- Reporting may benefit from a separate read model if it creates database contention for transactional paths.

## Weak assumptions or missing evidence

- The proposal assumes deployment separation is required before proving module boundaries are stable.
- It does not show that one team can own each extracted service independently.
- It does not describe data ownership, migration order, dual writes, rollback, or correctness validation.
- It does not estimate the new operational surface: deploy pipelines, alerts, dashboards, runbooks, incidents, and capacity management.

## Risks

- Operational cost: Three services add at least three deployables, service-to-service failure modes, monitoring surfaces, and on-call paths.
- Migration risk: Billing extraction can create data consistency issues if transactions span monolith and service boundaries.
- Ownership risk: If the same team owns all services, extraction may increase coordination cost without improving autonomy.
- Performance risk: Reporting service calls may add network overhead unless reporting uses an intentional read model or async projection.
- Maintenance risk: Shared libraries or shared database tables can recreate monolith coupling with more operational complexity.

## Lower-complexity alternatives

1. First define internal module boundaries for billing, notifications, and reporting inside the monolith.
2. Add contract tests around module APIs and data ownership.
3. Move reporting reads to a separate read model if database contention is the proven bottleneck.
4. Extract only the boundary with a clear independent scaling, ownership, deployment, or reliability benefit.

## Recommendation

Do not split all three services now. Stabilize module and data boundaries first, add observability around contention and change hotspots, then reassess whether one targeted extraction is justified.

Confidence: Medium. The recommendation should be revisited if production metrics show strong independent scaling needs or if ownership is already split across teams.
```
