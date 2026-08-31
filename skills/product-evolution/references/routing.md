# Routing Rules

Use these rules when `product-evolution`, `engineering-architecture`, `engineering-code-review`, and `engineering-delivery` could all appear relevant.

## Primary Question

Choose the perspective by the primary requested decision:

| Primary question | Skill |
|---|---|
| What should we do, why, when, and for whom? | `product-evolution` |
| How should the system evolve safely? | `engineering-architecture` |
| Is this concrete code change safe to merge? | `engineering-code-review` |
| What is the safest next delivery action? | `engineering-delivery` |

A concrete code artifact is a strong review signal, but it does not override the primary decision. A patch attached to a product request remains product work when the user is deciding whether to invest; a diff attached to a target-architecture question remains architecture work for that broad decision.

## Decision Graph

Use this order when several layers are needed:

```text
product-evolution
        |
engineering-architecture
        |
+-------------------------+
| engineering-code-review |
| engineering-delivery    |
+-------------------------+

engineering-code-review -> engineering-delivery
```

`product-evolution` decides whether an investment should exist, why, for whom, when, what MVP is acceptable, how to validate it, what should go first, and what should not be done.

`engineering-architecture` works after relevant product scope or technical requirements are confirmed. It decides how to build, migrate, draw boundaries, reduce technical risk, and choose the cheaper architecture to maintain.

`engineering-code-review` independently assesses a concrete implementation snapshot. It does not implement findings.

`engineering-delivery` diagnoses, implements, fixes, tests, validates, and prepares delivery artifacts. For a mixed review-and-fix request, review the immutable snapshot first, then hand confirmed work to delivery as a separate phase.

## Product Evolution Owns

- Whether to invest in an initiative.
- Whether a customer request should become product work.
- MVP boundaries and feature non-goals.
- Pilot gates and validation plans.
- Product roadmap and sequencing across initiatives.
- Priority arbitration across competing initiatives.
- Opportunity cost and simpler alternatives.
- Value, confidence, effort, support, and adoption tradeoffs.
- Current product health, maturity, adoption, retention, and customer-value assessment.

## Engineering Architecture Owns

- Technical design choices.
- Service, module, domain, and data boundaries.
- Migration strategy.
- Reliability, observability, deployment, and platform evolution.
- Architecture debt and technical roadmap.
- Production, deployment, release, and operational readiness.
- Repository-wide architecture assessment.

## Engineering Code Review Owns

- Selected code and file review.
- Diff, patch, and concrete change-set review.
- Commit, range, and branch review.
- GitLab merge request and GitHub pull request review.
- Incremental re-review.
- Audit of comments on a concrete code change.
- Read-only preparation of review comments; external provider actions belong to provider-specific adapters.

## Engineering Delivery Owns

- Investigation, debugging, and failure analysis.
- Implementation and code changes.
- Tests and generic validation.
- CI fixes.
- Local refactoring.
- PR preparation and change summaries.

## Ambiguous Cases

Current state:

- Explicit product health, maturity, adoption, retention, customer value, or highest-value next-investment questions: `product-evolution`.
- Generic project/repository review, current architecture, architecture quality, or readiness: `engineering-architecture`.
- Review of selected code or a concrete diff, commit, branch, MR, or PR: `engineering-code-review`.
- Failure diagnosis, debugging, CI, or runtime exceptions: `engineering-delivery`.
- Repository-only product evidence may support a conditional assessment, but it must not be presented as usage, retention, revenue, or customer validation.

Roadmap:

- Product initiatives, customer value, adoption, monetization, retention, support load, sales friction, MVP, and priority tradeoffs: `product-evolution`.
- Platform migration, architecture debt, service extraction, reliability, capacity, readiness, or technical roadmap: `engineering-architecture`.

Feature:

- "Should we build it?", "is it worth doing?", "what is the MVP?", or "what is the smallest useful solution?": `product-evolution`.
- "How should we design it?", "what boundary should it have?", or "how should architecture evolve?": `engineering-architecture`.
- "Review this implementation or PR": `engineering-code-review`.
- "Build it", "fix it", "write tests", or "ship it": `engineering-delivery`.

Customer request:

- "Should we satisfy this request and how much should we generalize it?": `product-evolution`.
- "Does this require a new boundary, data model, deployment shape, or capacity change?": `engineering-architecture`.
- "Review the concrete implementation against the accepted request": `engineering-code-review`.
- "Implement the agreed solution safely": `engineering-delivery`.

Mixed review intents:

- `Review this PR and fix confirmed blockers`: `engineering-code-review` first, then `engineering-delivery` for confirmed fixes.
- `Review architecture implications of this diff`: concrete change-level risks in `engineering-code-review`; broad architecture decisions in `engineering-architecture`.
- `Review this customer change request`: `product-evolution` unless a concrete implementation is the requested review target.
- `Prepare this PR for review`: `engineering-delivery`; preparing comments on someone else's concrete change is `engineering-code-review`.

If implementation is requested while product or architecture decisions remain unresolved, state the missing decision first. Do not produce delivery work for an initiative that has not passed the relevant decision gate unless the user explicitly requests a speculative exercise.
