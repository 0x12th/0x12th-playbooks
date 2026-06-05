# Exploration Budget

Use the smallest repository exploration budget that can support the requested decision.

Stop when enough evidence exists to answer the user. The goal is sufficient evidence for decision-making, not exhaustive repository exploration.

## Budgets

| Mode | Budget |
|---|---|
| Quick scan | 5-15 files |
| Focused review | 10-30 files |
| Design challenge | Only modules directly involved in the proposal |
| Decision support | Only evidence needed to compare options |
| Migration review | Migration path, affected contracts, data ownership, rollout, rollback, validation, observability |
| Full review | Start with a bounded hotspot pass; expand only while new evidence changes findings or roadmap |

## Quick Scan

Prefer repository hotspots first:

- Entrypoints
- Largest modules
- Largest routes or handlers
- Service wiring
- Dependency configuration
- Test coverage gaps
- Deployment configuration
- Migration and runtime configuration

Return the highest-impact findings. Do not keep exploring to fill a target count.

## Focused Review

Stay inside the requested scope.

Inspect the target module or service and only direct dependencies that materially affect the conclusion.

## Design Challenge

Stop after enough evidence exists to evaluate the proposal.

Do not attempt repository-wide review.

Focus on:

- Modules directly affected by the proposed change
- Contracts and data ownership touched by the proposal
- Migration, rollback, and operational impact
- Evidence for or against the assumed problem

## Stop Conditions

Stop gathering evidence when:

- The finding is already supported.
- Additional evidence is unlikely to change the recommendation.
- Confidence is high enough for the requested decision.
- The remaining uncertainty can be stated explicitly.
- Further exploration would only add examples of an already-supported pattern.
- The next useful evidence would require production data, stakeholder input, or implementation validation not available in the repository.

If confidence is low and more evidence is required, say what evidence is missing instead of continuing speculative exploration.
