# Routing Rules

Use these rules when `product-evolution`, `engineering-architecture`, and
`engineering-delivery` could all appear relevant.

`product-evolution` supports soft automatic activation. Route to it when the
primary question is product value, product scope, priority, MVP, customer
request evaluation, roadmap sequencing, or whether something should be built.

Do not route to it for implementation, debugging, CI, tests, coding tasks,
architecture design, migration strategy, production readiness, deployment
readiness, server/VPS fit, or runtime resource review.

## Primary Question

Choose the perspective by the primary question:

| Primary question | Skill |
|---|---|
| What should we do, why, when, and for whom? | `product-evolution` |
| How should the system evolve safely? | `engineering-architecture` |
| What is the safest next delivery action? | `engineering-delivery` |

## Strict Decision Chain

Use this order when multiple layers are needed:

```text
product-evolution
↓
engineering-architecture
↓
engineering-delivery
```

`product-evolution` decides whether the investment should exist, why, for whom,
when, what MVP is acceptable, how to validate it, what should go first, and what
should not be done.

`engineering-architecture` works only after the relevant product scope or
technical requirement is confirmed. It decides how to build, migrate, draw
boundaries, reduce technical risk, and choose the cheaper architecture to
maintain.

`engineering-delivery` works after the product and architecture decisions needed
for execution are settled. It implements, fixes, tests, validates, and prepares
delivery artifacts.

## Product Evolution Owns

- Whether to invest in an initiative
- Whether a customer request should become product work
- MVP boundaries and feature non-goals
- Pilot gates and validation plans
- Product roadmap and sequencing across initiatives
- Priority arbitration across competing initiatives
- Opportunity cost and simpler alternatives
- Value, confidence, effort, support, and adoption tradeoffs

## Engineering Architecture Owns

- Technical design choices
- Service, module, domain, and data boundaries
- Migration strategy
- Reliability, observability, deployment, and platform evolution
- Architecture debt and technical roadmap
- Technical risk after product scope is chosen

## Engineering Delivery Owns

- Investigation, debugging, and failure analysis
- Implementation and code changes
- Tests and validation
- CI fixes
- PR preparation and change summaries
- Code review, diff review, and patch review

## Ambiguous Cases

Roadmap:

- Product initiatives, customer value, adoption, monetization, retention,
  support load, sales friction, MVP, and priority tradeoffs:
  `product-evolution`.
- Platform migration, architecture debt, service extraction, reliability,
  capacity, deployment readiness, production readiness, or technical roadmap:
  `engineering-architecture`.

Feature:

- "Should we build it?", "do we need it?", "is it worth doing?", "what is the
  MVP?", or "what is the smallest useful solution?": `product-evolution`.
- "How should we design it?", "what boundary should it have?", or "how should
  the architecture evolve?": `engineering-architecture`.
- "Build it", "fix it", "write tests", or "ship it": `engineering-delivery`.

Customer request:

- "Should we satisfy this request and how much should we generalize it?":
  `product-evolution`.
- "Does this require a new system boundary, data model, deployment shape, or
  capacity change?": `engineering-architecture`.
- "How do we implement the agreed solution safely?": `engineering-delivery`.

Pilot:

- Pilot value, success gates, cohort, rollout, and investment decision:
  `product-evolution`.
- Pilot architecture, operational readiness, production readiness, capacity, or
  deployment path: `engineering-architecture`.
- Pilot implementation, instrumentation, test plan, and release mechanics after
  the scope and architecture are settled: `engineering-delivery`.

If the user asks for implementation but the product decision is unresolved,
state the missing product decision first. Do not produce architecture or delivery
work for an initiative that has not passed the value bar unless the user
explicitly wants a speculative exercise.
