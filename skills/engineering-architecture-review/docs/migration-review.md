# Migration Review

Use migration review mode for service extraction, service consolidation, framework replacement, database migration, runtime migration, sync-to-async changes, event-driven migration, and large staged refactors.

## Migration Questions

Before recommending migration, evaluate:

- Current pain
- Material benefit
- Migration duration
- Rollback or roll-forward complexity
- Parallel-run or coexistence requirements
- Correctness validation
- Observability during migration
- Ownership and operational readiness
- Cleanup of old paths

If current pain is not demonstrated, recommend against migration, postponement, or a smaller local intervention.

## Safety Requirements

A credible migration plan should define:

- Incremental phases
- Old/new path coexistence
- Backward-compatible contracts
- Data correctness validation
- Rollout and rollback or roll-forward
- Feature flags or staged rollout where useful
- Metrics, logs, traces, dashboards, and alerts
- Failure modes and mitigation
- Cleanup criteria

## Validation Options

Use validation methods appropriate to the migration:

- Contract tests
- Shadow reads
- Dual writes with reconciliation
- Backfill validation
- Checksums
- Sampled comparisons
- Migration smoke tests
- Replay tests
- Load or capacity checks
- Post-deploy verification queries

## Output

Use this structure when the user asks for migration review:

1. Recommendation
2. Current pain and expected benefit
3. Migration risks
4. Required phases
5. Validation plan
6. Rollback or mitigation plan
7. Observability requirements
8. Confidence and missing evidence
