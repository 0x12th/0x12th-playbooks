# Skill Selection

Select the skill from the user's primary requested decision, not from broad repository context or one attached artifact.

Use this decision graph when multiple layers are needed:

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

## Product Evolution

Use `product-evolution` for product value, current product health or maturity, scope, priority, MVP, customer-request evaluation, roadmap sequencing, or whether something should be built.

Use for:

- product investment decisions;
- current product health and maturity assessment;
- customer request evaluation;
- MVP boundaries;
- pilot evaluation;
- opportunity analysis;
- roadmap priority and arbitration;
- what not to do.

Do not use for implementation, debugging, architecture design, migration strategy, CI, tests, code review, production readiness, deployment readiness, server/VPS fit, or runtime resource review.

## Engineering Architecture

Use `engineering-architecture` when the primary question is:

```text
How should the system evolve safely?
```

Use for:

- architecture decisions and repository-wide architecture review;
- migrations and migration strategy;
- service/domain boundaries and ownership;
- reliability and observability architecture;
- deployment architecture;
- production, deployment, release, and operational readiness;
- runtime resources, VPS/server fit, capacity, and scaling;
- current and target architecture;
- system evolution, design challenge, and decision support.

Do not use for product investment decisions, direct implementation, or concrete code/change-set review. A diff can supply evidence for an architecture question without changing the primary architecture decision.

## Engineering Code Review

Use `engineering-code-review` when the primary question is:

```text
Is this concrete code change safe to merge?
```

Use for:

- selected code or file review;
- diff, patch, and change-set review;
- commit, range, and branch review;
- GitLab merge request and GitHub pull request review;
- equivalent provider change requests;
- incremental re-review;
- audit of comments on a concrete code change;
- preparation of provider-ready review comments;
- explicit provider review actions only after exact capability verification.

It is read-only by default. `prepare comments` is always dry-run. Unverified posting, approval, request-changes, and thread-resolution actions fail closed.

Do not use for generic project review, architecture/readiness decisions, product/PRD review, implementation or fixes, merge-conflict resolution, generic CI diagnosis, generic validation, PR preparation, or merging.

## Engineering Delivery

Use `engineering-delivery` when the primary question is:

```text
What is the safest next delivery action?
```

Use for:

- diagnosis and investigation;
- implementation and bug fixes;
- tests and CI fixes;
- local refactoring;
- generic validation;
- PR preparation;
- incremental improvements.

Default to read-only diagnosis. Edit only when the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

Do not use for concrete code/change-set review, product decisions, or architecture/readiness decisions.

## Examples

| User request | Skill |
|---|---|
| `Should we build this feature?` | `product-evolution` |
| `Assess current product health and recommend the next investment.` | `product-evolution` |
| `Review this customer change request.` | `product-evolution` unless a concrete implementation is the target |
| `Should we merge two tightly coupled modules?` | `engineering-architecture` |
| `Review this repository for production readiness.` | `engineering-architecture` |
| `Review architecture implications of this diff.` | `engineering-code-review` for concrete change risk, then `engineering-architecture` for broad decisions |
| `Review this selected function.` | `engineering-code-review` in Code Review mode |
| `Review this patch.` | `engineering-code-review` in Code Review mode |
| `Review commit abc123.` | `engineering-code-review` in Code Review mode |
| `Review this branch against main.` | `engineering-code-review` in Code Review mode |
| `Review GitLab MR !42.` | `engineering-code-review` in Change Request Review mode |
| `Review GitHub PR #42.` | `engineering-code-review` in Change Request Review mode |
| `Check the updated PR again.` | `engineering-code-review` in Incremental Re-review mode when prior state exists |
| `Audit comments on GitLab MR !42.` | `engineering-code-review` in Recommendation Audit mode |
| `Prepare review comments for this PR.` | `engineering-code-review`; dry-run |
| `Prepare this PR for review.` | `engineering-delivery` |
| `Why is CI failing?` | `engineering-delivery` in Diagnosis mode |
| `Fix the failing CI test.` | `engineering-delivery` in Implementation mode |
| `Resolve these merge conflicts.` | merge-conflict skill/workflow, not these review modes |

## Mixed Intents

- `Review this PR and fix confirmed blockers`: review the pinned snapshot with `engineering-code-review`, then hand confirmed findings to `engineering-delivery` as a separate implementation phase.
- `Quick-review and approve PR #42 if it looks fine`: use `engineering-code-review`, but quick/partial coverage cannot approve; any unverified action returns prepared output only.
- `Would you approve this deployment design?`: `engineering-architecture`; approval wording does not make a design/readiness decision a provider review action.
- `Prepare this PR`: `engineering-delivery` unless the user specifically requests review-comment preparation.
- `Audit these recommendations`: use `engineering-code-review` only when the recommendations concern a concrete code change.

## Generic Project Prompts

Generic project-level technical prompts normally use `engineering-architecture`, not `engineering-code-review` or `engineering-delivery`.

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Review this project.` | `engineering-architecture` | Quick Scan or Full Review + Architecture Quality |
| `What would you improve?` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Is it ready for production?` | `engineering-architecture` | Deployment Readiness Review |
| `What is the current architecture?` | `engineering-architecture` | Full Review + Architecture Quality |
| `Assess the current product health.` | `product-evolution` | Current Product Assessment |
| `Review this PR.` | `engineering-code-review` | Change Request Review |
| `Why is CI failing?` | `engineering-delivery` | Diagnosis |

## Selected Context

Selected code, files, pasted snippets, or explicitly named artifacts take precedence over repository-wide exploration, but the requested decision still controls routing.

- Selected implementation plus a review request: `engineering-code-review`.
- Selected implementation plus a fix request: `engineering-delivery`.
- Selected design/migration plan plus a decision request: `engineering-architecture`.
- Selected customer request plus an investment/scope decision: `product-evolution`.

Do not broaden a local request into a full repository review unless the user asks for one.
