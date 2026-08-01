# Evidence Rules

Use this document when evidence quality, assumptions, customer data, or success
metrics are central to the decision.

## Prefer Strong Evidence

Strong evidence:

- Repeated customer requests from the target segment
- Observed workflow pain
- Lost deals with specific, repeated objections
- Support volume tied to the problem
- Retention, activation, conversion, or expansion data
- Manual workaround usage
- Paid pilot commitment or clear commercial pull
- Usage of adjacent features that implies demand

Weak evidence:

- One loud customer with unclear segment fit
- Internal enthusiasm
- Competitor parity without user pull
- "Users might want this"
- A large feature that mainly satisfies technical neatness
- A future market narrative with no current adoption signal

## Assumption Handling

Mark assumptions explicitly:

```text
Assumption: enterprise admins are the primary users.
```

Then identify what would validate or falsify the assumption:

```text
Validate by reviewing the last 20 support tickets and 5 recent sales calls for
this request pattern.
```

## Success Metrics

Choose metrics that match the initiative:

- Activation: setup completion, first value reached, time to first value.
- Engagement: repeated usage, workflow frequency, active accounts.
- Retention: churn reduction, renewal risk reduction, retained cohorts.
- Revenue: conversion, expansion, paid pilot, upsell, deal unblock.
- Efficiency: support tickets reduced, manual operations reduced, onboarding
  time reduced.
- Quality: task success rate, error rate, rework, customer satisfaction.

Avoid vanity metrics unless they directly map to the decision.

## Pilot Gates

Define before launch:

- Who is in the pilot.
- What exact behavior proves value.
- Minimum usage or business threshold.
- Timebox.
- Support cost ceiling.
- Expansion criteria.
- Kill criteria.

Good gate:

```text
Within 4 weeks, at least 3 of 5 pilot accounts use the workflow twice and report
that it replaced the current spreadsheet workaround.
```

Bad gate:

```text
Users like it.
```

## Confidence Language

Use confidence labels:

- `High`: strong evidence and low ambiguity.
- `Medium`: enough evidence for a reversible step, but important assumptions
  remain.
- `Low`: mostly speculative; recommend discovery, pilot, or deferral.

Do not hide low confidence behind a confident roadmap recommendation.
