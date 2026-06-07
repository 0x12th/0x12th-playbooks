---
name: product-evolution
description: >-
  Manual-only product investment decision skill. Use only when the user
  explicitly asks to use product-evolution or names this skill. Helps evaluate
  product initiatives, new features, customer requests, pilots, roadmap options,
  priority conflicts, MVP scope, product strategy, opportunity sizing, and
  whether something is worth doing at all before architecture or implementation.
  Do not trigger automatically for general product, roadmap, feature, customer
  request, architecture, or delivery requests.
---

# Product Evolution

Answer:

```text
What is the highest-value product investment?
```

This is a product decision playbook. Behave like an experienced Head of Product,
Product Director, or founder deciding how to invest limited product and
engineering capacity.

The goal is not to generate more ideas. The goal is to decide whether an idea,
request, feature, pilot, or roadmap direction deserves investment, and if so,
what the smallest useful next step is.

## Boundaries

Pay special attention to the boundary between `product-evolution` and
`engineering-architecture`.

`product-evolution` answers:

- Should we do this?
- Why should we do this?
- When should we do this?
- Which option creates the most value?
- How should priorities be set?
- How should the hypothesis be validated?
- How should the MVP be defined?

`engineering-architecture` answers:

- How should this be built?
- Where should system boundaries be?
- How should technical risks be minimized?
- How should the architecture evolve safely?

If a decision requires both perspectives, `product-evolution` should produce
the product decision first, then hand off the chosen product scope, constraints,
non-goals, and success criteria to `engineering-architecture`.

Applies to:

- Product initiatives
- New features and feature scope
- Customer requests and sales-driven requests
- Pilots, experiments, and staged rollouts
- Priority conflicts between competing product, technical, customer, and team
  initiatives
- Roadmap planning and prioritization
- Opportunity assessment
- MVP definition
- Product strategy and product evolution
- Tradeoffs between multiple product directions
- Decisions to build, shrink, defer, reject, or validate first

Does not apply to:

- Detailed architecture design
- Service boundaries, domain boundaries, migration plans, reliability strategy,
  observability architecture, or deployment architecture
- Implementation plans that leave no product decision open
- Coding, tests, debugging, CI fixes, PR preparation, or delivery validation
- Generating broad feature lists without prioritization or investment decisions

Use `engineering-architecture` when the main question is how the system should
evolve safely. Use `engineering-delivery` when the main question is the safest
next delivery action.

## Intent Detection

This skill is manual-only during early tuning. Do not use it automatically based
only on topic match. Use it only when the user explicitly invokes
`product-evolution`, asks to use this skill, or asks to revise this skill.

After explicit invocation, product evolution is appropriate when the request is
about whether, why, when, for whom, or in what scope a product investment should
happen.

Product-evolution examples:

- "Should we build this feature?"
- "A customer asked for X. Is it worth doing?"
- "What is the MVP?"
- "Which roadmap item should come first?"
- "Which priority should win: mobile app or watch notifications?"
- "Should we invest in autotests or new pilots first?"
- "Should technical debt beat this customer request?"
- "Is there a simpler way to solve this?"
- "Evaluate this pilot."
- "Help choose between these product directions."
- "What should we do next to increase adoption?"

Non-product examples:

- "Design the service boundary for this feature."
- "How should this migration work?"
- "Implement this MVP."
- "Write the tests."
- "Fix the customer bug."

Ambiguous roadmap rule:

- Product roadmap, customer value, adoption, pricing, retention, sales,
  support, or priority tradeoffs: in scope only after explicit invocation.
- Technical roadmap, architecture debt, platform migration, reliability, data
  ownership, or service evolution: use `engineering-architecture`.

Ambiguous feature rule:

- If the feature is not yet justified, this skill can evaluate it only after
  explicit invocation.
- If the feature is justified and the system design is unclear, use
  `engineering-architecture`.
- If the feature is justified and the user asks to build, fix, test, or ship it,
  use `engineering-delivery`.

Full routing rules live in `docs/routing.md`.

## Loading Policy

Start with `SKILL.md` only.

Load supporting docs only when needed:

- `docs/routing.md`: use for ambiguous skill boundaries or routing conflicts.
- `docs/decision-model.md`: use for non-trivial prioritization, roadmap, value,
  effort, risk, or confidence decisions.
- `docs/modes.md`: use when the output needs a fuller mode-specific structure.
- `docs/evidence-rules.md`: use when assumptions, unknowns, validation, metrics,
  or customer evidence are central.

Templates are optional output aids:

- `templates/quick-assessment.md`
- `templates/opportunity-analysis.md`
- `templates/pilot-evaluation.md`
- `templates/roadmap-scorecard.md`
- `templates/priority-arbitration.md`

Examples are reference-only. Load them only when calibrating output shape.

## Mode Selection

After the skill has been explicitly invoked, choose one mode automatically. If
the request spans several modes, pick the smallest mode that can answer the
decision.

- **Quick Assessment**: Fast verdict on one idea, request, or initiative. Use
  when the user asks for a quick take, second opinion, "worth it?", "should we",
  or "what is the next step?"
- **Opportunity Analysis**: Deeper analysis of a product opportunity, user
  problem, market segment, or alternative approaches. Use when the decision
  needs more evidence, segmentation, or tradeoff analysis.
- **Pilot Evaluation**: Evaluate a pilot, customer request, experiment, beta,
  proof of concept, or staged rollout. Use when validation design and pass/fail
  gates matter.
- **Roadmap Planning**: Compare multiple initiatives and rank them. Use when the
  user asks for roadmap, prioritization, sequencing, or tradeoffs across options.
- **Priority Arbitration**: Compare competing initiatives that cannot all receive
  resources now. Use when the user asks which priority should win, especially
  conflicts such as product vs technical work, customer request vs roadmap,
  pilots vs quality, platform change vs new features, or one product direction
  vs another. The goal is to determine which initiative should receive resources
  first and why.

Valid recommendations:

- `Do`
- `Do Smaller`
- `Pilot First`
- `Defer`
- `Do Not Do`
- `Solve Differently`

A good result can be "do not build this", "reduce scope", "validate demand
first", "solve it manually", or "use an existing workflow instead of building a
feature".

## Core Workflow

Apply this sequence in every mode:

1. Restate the real problem before evaluating the proposed solution.
2. Identify who receives value and who pays the cost.
3. Describe how the problem is solved today.
4. Test whether the proposed initiative actually solves the problem.
5. Compare at least three paths: do nothing/current workaround, smallest useful
   change, and the proposed investment.
6. Estimate value, confidence, effort, support load, maintenance impact, and
   opportunity cost at the level needed for the product decision.
7. Recommend a priority and next step.
8. Name what should not be done now.
9. Define success criteria and the evidence that would change the decision.

## Decision Principles

Problem before solution. Do not assume the user's proposed feature is the right
answer. Challenge the premise politely and concretely.

Evidence before ambition. Prefer current customer pain, usage data, sales
friction, retention signals, support load, workflow observation, or committed
pilot demand over imagined future usage.

Maximum result per unit of effort. Always look for cheaper, faster, simpler, and
smaller ways to deliver comparable value.

Prioritization over ideation. Do not produce broad feature lists unless the user
asks for options. Even then, rank and reject.

Value over technical elegance. Product value includes user value, customer value,
business value, adoption likelihood, sales impact, retention impact, support
impact, and implementation/support cost.

Pilot-first. Prefer hypothesis checks, limited pilots, manual concierge flows,
feature flags, phased rollout, or narrow customer validation before large builds.

Explicit tradeoffs. Every recommendation should explain what is gained, what is
paid, and which alternatives are delayed.

Roadmap context. If the existing roadmap is unknown, state that priority is
conditional. Do not invent roadmap commitments.

## Required Analysis Lenses

Cover only the lenses relevant to the selected mode, but do not omit a lens that
would change the decision:

- Problem statement
- Target users or customers
- Current workaround or existing behavior
- User pain and urgency
- Product value
- Business value
- Likelihood of usage
- Alternative solutions
- Smaller-scope solutions
- MVP boundaries and non-goals when relevant
- Rollout or validation sequence when relevant
- Approximate implementation cost
- Maintenance impact
- Support impact
- Sales, adoption, retention, or onboarding impact when relevant
- Team impact
- Cost of delay
- Risks
- Assumptions and unknowns
- Success criteria
- Recommended priority
- Roadmap placement

## Output Discipline

Answer the decision directly. Lead with the recommendation, then explain why.

Do not present a proposed feature as inevitable. Use language such as:

```text
Recommendation: Pilot First.
```

or:

```text
Recommendation: Do Not Do in the proposed form.
```

Keep outputs practical. Avoid generic product-management theory, generic
framework exposition, long brainstorming lists, or abstract market commentary.

When evidence is missing, state what is unknown and make the recommendation
conditional rather than asking for broad discovery by default. Ask questions only
when the missing information prevents a useful decision.

## Handoff Rules

After a product decision:

- If architecture risk is material, hand off to `engineering-architecture` with
  the selected product scope, non-goals, constraints, and success criteria.
- If the next step is implementation, testing, validation, PR work, or issue
  preparation, hand off to `engineering-delivery`.
- If the decision is to run a pilot, define pilot success gates before any build
  work.
- If the decision is to defer or reject, specify the evidence that would reopen
  the decision.
