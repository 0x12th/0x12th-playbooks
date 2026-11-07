# Product Boundary Examples

This reference clarifies product-specific ambiguities; it is not a second global
routing matrix. The skill's entry-point triggers work without this reference.

- “Should we build it?”, “is it worth doing?”, MVP, priority and the smallest
  useful solution are product decisions. Establish value and scope before design.
- Explicit product health, maturity, adoption, retention or customer value belongs
  here. Repository artifacts alone cannot establish usage, revenue or customer
  validation; state unknowns and make recommendations conditional.
- A customer change request remains product work unless the requested decision is
  assessment of a concrete implementation. An attached patch alone does not change
  a product investment question into code review.
- Generic project/repository technical review belongs to architecture, not product
  assessment; architecture selects its own mode.
- Technical roadmap, migration, service boundaries, capacity and readiness decisions
  are architecture work. Do not invent product scope from technical constraints.
- Once product scope is accepted, concrete implementation review belongs to code
  review; implementation and validation belong to delivery. Diagnosis stays
  read-only; explicit outcome intent requiring changes permits only necessary
  scoped edits. Release preparation does not authorize publication or push.

For combined work, carry forward scope, non-goals, constraints and success criteria
only as needed. Review-and-fix has a read-only evidence/findings phase followed by
bounded authorized implementation under delivery rules, without a required runtime
switch/handoff API. If required guidance is absent, disclose it and preserve safe
scope and user work. Product approval by itself is not implementation authorization.

## Product Prompt Examples

- "Should we build this feature?"
- "A customer asked for X. Is it worth doing?"
- "Do we need this feature?"
- "What is the MVP?"
- "What is the smallest useful solution?"
- "What is the smallest useful next step?"
- "Which roadmap item should come first?"
- "What should come first?"
- "Which priority should win: mobile app or watch notifications?"
- "Should we invest in autotests or new pilots first?"
- "Should technical debt beat this customer request?"
- "Should this customer request become roadmap work?"
- "Is there a simpler way to solve this?"
- "Evaluate this pilot."
- "Help choose between these product directions."
- "What should we do next to increase adoption?"
- "Assess the current product and recommend the highest-value next investment."

## Non-Product Prompt Examples

- "Design the service boundary for this feature."
- "How should this migration work?"
- "Is this ready for production?"
- "Can I deploy this to a VPS?"
- "Review runtime resource usage."
- "Review this repository."
- "Implement this MVP."
- "Write the tests."
- "Fix the customer bug."
- "Review this pull request for regressions."
