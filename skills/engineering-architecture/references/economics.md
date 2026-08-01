# Economics

Evaluate economics before recommending architecture changes.

Architecture recommendations must account for:

- Implementation cost
- Migration cost
- Operational cost
- Team cognitive load
- 1-3 year maintenance cost
- Ownership impact
- Rollout and rollback cost
- Complexity delta

## Cost Types

**Implementation cost:** engineering effort, coordination, testing, review, documentation, and delivery time.

**Migration cost:** data movement, coexistence, compatibility layers, dual writes, validation, rollout, rollback, cleanup, and user impact.

**Operational cost:** new deployables, monitoring, alerts, dashboards, on-call load, incidents, dependencies, capacity management, runbooks, and deployment pipelines.

**Maintenance cost:** expected ownership over 1-3 years, dependency churn, test burden, documentation needs, support load, and future change frequency.

**Team cognitive load:** new concepts, boundaries, debugging paths, tooling, local development complexity, ownership handoffs, and onboarding cost.

## Recommendation Rule

Compare estimated cost against expected benefit.

If cost exceeds expected benefit, recommend:

- No change
- Postponement
- More evidence
- A smaller local intervention

Large migrations or service extractions require material current pain, measurable expected benefit, and a credible migration plan.

## Confidence Gates

Use confidence to control recommendation strength:

- **High confidence:** prioritize the finding; planning may proceed.
- **Medium confidence:** finding is valid, but implementation needs more evidence or a narrower first step.
- **Low confidence:** stop and request or list missing evidence.

Do not recommend large architecture changes with low confidence.
