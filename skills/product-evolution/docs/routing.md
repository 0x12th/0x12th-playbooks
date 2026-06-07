# Routing Rules

Use these rules when `product-evolution`, `engineering-architecture`, and
`engineering-delivery` could all appear relevant.

`product-evolution` is manual-only during early tuning. Do not route to it
automatically unless the user explicitly asks to use `product-evolution` or
names this skill.

## Primary Question

When explicit invocation allows product-evolution, choose the perspective by the
primary question:

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
  support load, sales friction: `product-evolution` only after explicit
  invocation.
- Platform migration, architecture debt, service extraction, reliability
  roadmap: `engineering-architecture`.

Feature:

- "Should we build it?" or "what is the MVP?": `product-evolution` only after
  explicit invocation.
- "How should we design it?": `engineering-architecture`.
- "Build it", "fix it", "write tests": `engineering-delivery`.

Customer request:

- "Should we satisfy this request and how much should we generalize it?":
  `product-evolution` only after explicit invocation.
- "How do we implement the agreed solution safely?": `engineering-delivery`.
- "Does this require a new system boundary or data model?":
  `engineering-architecture`.

Pilot:

- Pilot value, success gates, cohort, rollout, and investment decision:
  `product-evolution` only after explicit invocation.
- Pilot implementation, instrumentation, test plan, and release mechanics:
  `engineering-delivery`.

If the user asks for implementation but the product decision is unresolved,
state the missing product decision first. If the user did not explicitly invoke
`product-evolution`, do not switch into this skill automatically. Do not produce
architecture or delivery work for an initiative that has not passed the value bar
unless the user explicitly wants a speculative exercise.
