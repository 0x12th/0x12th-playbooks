# Mode Guides

Use this document when `SKILL.md` is not enough to shape the output.

## Contents

- Quick Assessment
- Current Product Assessment
- Opportunity Analysis
- Pilot Evaluation
- Roadmap Planning
- Priority Arbitration

## Quick Assessment

Use for a fast verdict on one idea, feature, request, or initiative.

Output shape:

1. Recommendation with material cost and uncertainty.
2. Problem and who benefits.
3. Current workaround or minimal alternative.
4. Next step and evidence/criterion that would reopen the decision.

Keep it short. Do not build a full business case or require expanded workflow/lens sections. Add roadmap placement or rollout detail only if it changes the decision.

## Current Product Assessment

Use when the user explicitly asks for the current state, health, maturity, or
product audit of an existing product rather than one proposed initiative.

Output shape:

1. State verdict and confidence.
2. Product problem, target users, and current workaround.
3. Evidence provenance: observed product or customer data, repository or
   artifact evidence, and unknowns those artifacts cannot establish.
4. Product health by decision-relevant dimensions such as core workflow,
   activation, engagement, retention, quality, distribution, business model,
   and operating constraints. Omit irrelevant dimensions.
5. Product maturity separated from technical readiness. Passing tests,
   architecture quality, and performance are not adoption evidence.
6. Current course, smallest useful change, broader investment, and a manual or
   pilot validation path.
7. Highest-value next investment, roadmap placement, success gates, and what not
   to do now.

Keep the audit proportional to available evidence. Do not treat repository
stars, commit volume, test count, or internal technical activity as customer
validation. If live usage, customer interviews, retention, revenue, sales, or
support signals are unavailable, make the verdict conditional. The next
investment may be instrumentation, cohort review, interviews, support or sales
analysis, or manual workflow validation rather than a feature build.

## Opportunity Analysis

Use for deeper opportunity exploration before committing roadmap capacity. Also
use it to define MVP boundaries, non-goals, rollout sequence, and product success
criteria for a specific feature or initiative.

Output shape:

1. Executive recommendation.
2. Problem and current workaround.
3. Target segments and user jobs.
4. Pain severity and frequency.
5. Product and business value.
6. Alternatives, including non-feature options.
7. Scope options: no-build, MVP, small, medium, full.
8. MVP boundaries, non-goals, and rollout sequence when relevant.
9. Value, confidence, effort, support, and maintenance tradeoffs.
10. Risks, assumptions, unknowns, and validation plan.
11. Roadmap recommendation.

Avoid long ideation lists. Include only alternatives that could realistically
win the decision.

## Pilot Evaluation

Use for pilots, experiments, customer-specific requests, beta programs, and
proofs of concept.

Output shape:

1. Recommendation: run, shrink, defer, or reject the pilot.
2. Hypothesis.
3. Pilot cohort and inclusion criteria.
4. Minimal pilot scope.
5. Manual or low-build path.
6. Success gates.
7. Kill criteria.
8. Expansion criteria.
9. Support and operational load.
10. Post-pilot decision path.

A pilot without pass/fail criteria is just hidden roadmap commitment. Always
define gates before recommending the pilot.

## Roadmap Planning

Use when comparing multiple initiatives.

Output shape:

1. Ranking.
2. Decision criteria.
3. Initiative scorecard.
4. Recommended sequence.
5. What to defer or reject.
6. Capacity and dependency assumptions.
7. Risks in the proposed roadmap.
8. Evidence needed before promoting deferred items.

Favor a smaller number of active initiatives. Roadmaps should reduce focus risk,
not maximize visible activity.

## Priority Arbitration

Use when the user is not asking for a full roadmap or detailed scope analysis, but for a
decision between competing priorities such as:

- Mobile app vs watch notifications.
- Autotests vs new pilots.
- C++ to Python migration vs new features.
- Technical debt vs customer request.

Goal:

Determine which initiative should receive resources first and why.

Evaluate:

1. Expected value.
2. Cost.
3. Risk.
4. Urgency.
5. Roadmap impact.
6. Customer impact.
7. Team impact.
8. Cost of delay.

Output shape:

1. Recommendation and winner.
2. What loses or waits.
3. Comparison table.
4. Rationale.
5. Conditions that would reverse the decision.
6. Smallest compromise, if one exists.
7. Next step.

Do not average away a hard tradeoff. If one option should clearly lose, say so.
