# Skill Selection

This is the canonical maintainer cross-skill routing document. Select from the user's primary requested decision, not broad repository context or one attached artifact. README/bootstrap are entry aids; each installed SKILL.md keeps its own positive/negative triggers and safe core. Installed skills do not depend on this nonbundled document.

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
- read-only preparation of review comments.

It is read-only. `prepare comments` is always dry-run; external provider actions belong to provider-specific adapters.

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

Diagnostic questions and assessment-only requests stay read-only. Explicit intent for an outcome requiring project changes authorizes scoped edits when the target is clear; examples are not a closed verb list. Polite edit requests such as “Can you fix this?” retain edit intent despite their question form. “Доведи до рабочего состояния”, “сделай чтобы CI был зелёным” and “закончи задачу” can authorize necessary edits. Clarify an unclear target. Assessing removability does not authorize deletion. “Подготовь релиз” permits necessary local preparation, not publication, push or destructive operations.

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

- `Review this PR and fix confirmed blockers`: finish read-only evidence/findings against the pinned change snapshot (or exact selected text), then apply `engineering-delivery` rules to authorized confirmed fixes in a bounded implementation phase. No runtime switch/handoff API is needed. If required guidance is missing, disclose it and preserve authorization, selected scope, user work and validation safeguards.
- `Quick-review PR #42`: use `engineering-code-review`, but quick/partial coverage cannot produce an unconditional `Pass`.
- `Is this deployment design acceptable?`: use `engineering-architecture`; an attached change does not replace the architecture decision.
- `Prepare this PR`: `engineering-delivery` unless the user specifically requests review-comment preparation.
- `Audit these recommendations`: use `engineering-code-review` only when the recommendations concern a concrete code change.

## Generic Project Prompts

Generic project-level technical prompts normally use `engineering-architecture`, not `engineering-code-review` or `engineering-delivery`.

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Review this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Perform a full architecture review.` | `engineering-architecture` | Full Review + Architecture Quality |
| `Review this repository and plan its technical evolution.` | `engineering-architecture` | Full Review + Technical Evolution |
| `Review only this module’s architecture.` | `engineering-architecture` | Focused Review |
| `What would you improve?` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Is it ready for production?` | `engineering-architecture` | Deployment Readiness Review |
| `What is the current architecture?` | `engineering-architecture` | Full Review + Architecture Quality |
| `Assess the current product health.` | `product-evolution` | Current Product Assessment |
| `Review this PR.` | `engineering-code-review` | Change Request Review |
| `Why is CI failing?` | `engineering-delivery` | Diagnosis |

Broad repository/project review asking about scaling, migration, technical sequencing or architecture evolution defaults to Full Review + Technical Evolution unless explicitly fast or bounded. Named growth features alone do not limit that scope.

## Selected Context

Selected code, files, pasted snippets, or explicitly named artifacts take precedence over repository-wide exploration, but the requested decision still controls routing.

- Selected implementation plus a review request: `engineering-code-review`; standalone code uses exact supplied scope, only necessary direct dependencies, supported findings, verdict and material validation limits—not an unconditional Git/provider inventory.
- Selected implementation plus a fix request: `engineering-delivery`.
- Selected design/migration plan plus a decision request: `engineering-architecture`.
- Selected customer request plus an investment/scope decision: `product-evolution`.

Do not broaden a local request into a full repository review unless the user asks for one.
