# Review Rules

Use these rules when the core contract needs deeper finding, evidence, or risk guidance.

## Evidence Hierarchy

Requirements evidence is contextual, in this order:

1. Explicit user review objective.
2. Accepted repository specs, ADRs, and linked issue acceptance criteria.
3. MR/PR description.
4. Commit messages and branch names as weak clues.
5. Tests and existing code as behavior evidence, not automatic product requirements.

Missing formal requirements do not block ordinary correctness review. Mark requirements coverage as unverified when needed. If sources conflict and authority is unclear, expose the conflict rather than choosing one silently.

When an applicable primary criterion and a derived design or ADR are available, distinguish what the criterion requires, how the design interprets it, and what reachable code and tests actually do. Green design-derived tests cannot settle a conflict with an unambiguous accepted criterion. For example, rejecting every result in a batch contradicts an explicit requirement to retain valid items even if the design and tests expect all-or-nothing behavior. Report the narrow mismatch; ask about disputed source authority or unspecified cases rather than inventing policy.

Repository standards, in this order:

1. Repository instructions and documented contracts.
2. Compiler, typechecker, formatter, linter, and policy tools.
3. Language and framework guarantees.
4. Risk-based maintainability heuristics.

Project rules override generic preferences. Do not repeat findings already reliably enforced by tooling. Naming preferences and code smells are not defects without a concrete risk.

## Risk Lenses

Use only relevant lenses, but inspect them independently before deduplication:

- Requirements and scope: the change implements the accepted behavior and does not silently broaden it.
- Correctness and regression: changed control flow, edge cases, defaults, state transitions, serialization, and failure behavior.
- Data and concurrency: integrity, transactions, retries, idempotency, ordering, locking, races, and partial failure.
- Reliability: timeouts, cancellation, cleanup, resource ownership, error propagation, and recovery.
- Security and privacy: trust boundaries, authorization, validation, injection, sensitive data, logging, and audience.
- Compatibility: public APIs, schemas, migrations, protocols, configuration, feature flags, and downgrade/coexistence behavior.
- Performance and resources: only when reachability and workload make the risk material.
- Tests and CI: whether evidence executes the changed behavior and belongs to the pinned snapshot.
- Repository standards: documented contracts and tool-backed requirements.
- Maintainability: only concrete delivery impact, likely misuse, or costly local complexity.

Aggregate findings into one report. A defect found through several lenses remains one root-cause finding.

## Finding Record

Record:

```text
title
review lens
severity: critical | high | medium | low
disposition: blocking | non-blocking
confidence: high | medium | low
current location
immutable evidence provenance
problem and root cause
trigger or reproducer
observable impact
minimal fix direction
validation status
change attribution
discussion status
```

One finding covers one root cause, not a bundle of symptoms. Locations must identify the current pinned revision, not only a mutable branch line number.

## Severity, Disposition, and Confidence

Severity is impact plus reachability:

- `critical`: realistic compromise, irreversible data loss, broad outage, or similarly catastrophic impact.
- `high`: substantial core-behavior, security, data-integrity, public-contract, or compatibility failure.
- `medium`: confirmed limited-impact or uncommon failure, possibly with a workaround.
- `low`: small but concrete issue without serious delivery risk.

Disposition is independent:

- `blocking`: the change should not merge safely until resolved.
- `non-blocking`: useful and concrete, but safe merge does not depend on it.

Confidence is independent:

- High-confidence issues may be confirmed findings.
- Medium-confidence uncertainty may be a concrete question when the answer affects merge safety.
- Low-confidence speculation is suppressed.
- Blocking disposition normally requires high confidence.
- High potential impact with insufficient evidence becomes a question or `Blocked by missing evidence`, not an inflated defect.

## Change Attribution

Exclude unrelated pre-existing defects. Include a pre-existing issue only when the reviewed change:

- exposes it to a new reachable path;
- worsens its impact or frequency;
- depends on its broken assumption;
- claims to fix it but does not; or
- cannot safely merge without addressing it.

State this attribution explicitly when it is not obvious. An unchanged failure site can be newly reachable because a change supplies different inputs. When safe and useful, compare baseline and changed paths under the same inputs and controlled dependency responses, then explain both the old failure-handling gap and the new trigger.

## Test Findings

Do not demand tests mechanically. Raise a missing or weak-test finding only for a specific risk, such as:

- regression for a fixed bug;
- new behavior or error path;
- public API or serialized contract;
- security boundary;
- schema or migration behavior;
- retry, timeout, concurrency, ordering, or idempotency behavior;
- a test that appears relevant but does not execute the changed path.

Distinguish a concrete test defect from a general validation gap.

## Non-blocking Improvements

Include only high-value, local, actionable improvements tied to:

- concrete complexity that makes the changed behavior error-prone;
- meaningful duplication;
- brittle tests;
- misleading contracts;
- likely misuse.

Exclude taste, naming preferences without impact, equivalent alternatives, speculative abstractions, broad refactors, and tool-enforced trivia.

## Architecture Concerns

Describe the concrete change-level risk first. A broad service-boundary, migration, target-architecture, or readiness decision belongs to `engineering-architecture`.

Report a blocking design question only when the concrete change genuinely cannot merge safely without that decision. Do not turn the review into a repository-wide architecture assessment.

## Recommendation Audit

Independently verify each supplied recommendation and classify it as:

- `Correct`;
- `Correct but optional`;
- `Incorrect`;
- `Already addressed`;
- `Invalid premise`.

Give concise evidence for each classification. Missing evidence limits confidence; it does not justify accepting a recommendation as a batch. Recommendation Audit alone does not create a whole-change verdict.
