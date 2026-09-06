# ADR Draft Template

Use this as a requested decision record, not a replacement review contract.
Lead the response with the `SKILL.md` verdict and retain only useful sections.
Give each significant recommendation confidence and a technical disposition;
ADR lifecycle status is not a technical disposition.

# ADR: <Decision title>

**Status:** Proposed | Accepted | Superseded | Deprecated  
**Date:** YYYY-MM-DD  
**Owners:**  
**Related findings/tasks:**

## Context

Describe the current situation, constraints, and forces. Include evidence rather than preference where possible.

- Current behavior:
- Pain points or risks:
- Operational constraints:
- Delivery or maintainability constraints:
- Ownership or organizational constraints:
- Performance or capacity constraints:
- Migration constraints:
- Relevant alternatives considered:

## Decision

State the architecture decision clearly.

**Confidence:** High | Medium | Low — evidence or limitation

**Technical disposition:** Required before implementation | Next safe step | Defer pending evidence | Do not implement

We will...

## Rationale

Explain why this option is preferred.

- How it improves system behavior, delivery speed, reliability, performance, maintainability, or operational risk:
- Why alternatives were rejected:
- Why this is appropriately sized for the problem:
- Why the operational cost, cognitive load, migration cost, and 1–3 year maintenance cost are justified:

## Consequences

### Positive

- 

### Negative / Tradeoffs

- 

### Evolution Cost

- Operational cost:
- Team cognitive load:
- Migration cost:
- 1–3 year maintenance impact:
- Complexity delta:

### Organizational Impact

- Ownership changes:
- Cross-team dependency changes:
- Operational responsibility changes:

### Performance Impact

- CPU:
- Memory:
- Queues/backlogs:
- Network:
- Database contention:
- Capacity/resource utilization:

### Migration and Rollback

- Incremental migration path:
- Old/new path coexistence:
- Correctness validation:
- Rollback or roll-forward strategy:
- Required observability during migration:

### Risks and Mitigations

| Risk | Mitigation |
|---|---|
|  |  |

## Implementation Plan

1. 
2. 
3. 

## Validation

- Tests:
- Performance checks:
- Observability:
- Rollout checks:
- Correctness checks during migration:
- Rollback or mitigation:

## Review Date

Review this decision by: YYYY-MM-DD or after <trigger/event>.
