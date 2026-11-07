---
name: product-evolution
description: >-
  Use for product investment, scope, and current-product assessment: product
  health, maturity, adoption, retention, customer requests, roadmap priorities,
  feature scope, MVP discussions, pilots, priority conflicts, product strategy,
  opportunity sizing, what should come first, and the smallest useful solution
  before architecture or implementation. Do not use for generic repository
  review, implementation, debugging, architecture design, migration strategy,
  CI, tests, production readiness, deployment readiness, or runtime resource review.
---

# Product Evolution

Answer:

```text
What is the highest-value product investment?
```

This is a product decision playbook. Behave like an experienced Head of Product,
Product Director, or founder deciding how to invest limited product and
engineering capacity.

The goal is not to generate more ideas. The goal is to assess the current product
or decide whether an idea, request, feature, pilot, or roadmap direction deserves
investment, and identify the smallest useful next step.

## Boundaries

Use for product investment and scope decisions: current product health and
maturity, adoption, retention, customer value, opportunities, features and MVPs,
customer or sales-driven requests, pilots, experiments, staged rollouts, roadmap
priorities, and conflicts over limited product, technical, customer, or team
capacity. Decide whether to build, shrink, defer, reject, or validate first.

Do not use for unprioritized feature lists, detailed system design, or execution
that leaves no product decision open.

## Intent Detection

Route by the primary question:

- **Product decision:** whether, why, when, for whom, or in what scope to invest;
  what should come first; the smallest useful solution; or explicit product
  health, maturity, adoption, retention, and customer-value assessment. Use this
  skill, including product-roadmap tradeoffs involving pricing, sales or support.
- **Technical decision:** how to build or evolve a system; technical roadmaps,
  architecture debt, service/data boundaries, migration, platform evolution,
  reliability, observability, production/deployment/release readiness, capacity,
  scaling, server fit, or generic repository technical review. Use
  `engineering-architecture`.
- **Concrete implementation assessment:** correctness or merge safety of selected
  code, diffs, patches, commits, branches, merge requests, or pull requests. Use
  `engineering-code-review`.
- **Execution:** implementation, diagnosis, debugging, tests, CI fixes, PR
  preparation, or validation. Use `engineering-delivery`.

For a feature, establish product justification here when it is still open. Once
justified, unclear system design belongs to architecture; an explicit request to
build, fix, test, or ship belongs to delivery. A customer request or an attached
patch alone does not change a product investment question into code review.

When product and architecture decisions are both needed, establish the product
decision first and carry its scope, non-goals, constraints, and success criteria
into architecture. Product-specific examples are in `references/routing.md`;
this entry point remains independently usable.

## Loading Policy

Start with `SKILL.md` only.

Load supporting references only when needed:

- `references/routing.md`: use for ambiguous skill boundaries or routing conflicts.
- `references/decision-model.md`: use for non-trivial prioritization, roadmap, value,
  effort, risk, or confidence decisions.
- `references/modes.md`: use when the output needs a fuller mode-specific structure.
- `references/evidence-rules.md`: use when assumptions, unknowns, validation, metrics,
  or customer evidence are central.

Templates are optional output aids:

- `templates/quick-assessment.md`
- `templates/current-product-assessment.md`
- `templates/opportunity-analysis.md`
- `templates/pilot-evaluation.md`
- `templates/roadmap-scorecard.md`
- `templates/priority-arbitration.md`

Examples are reference-only. Load them only when calibrating output shape.

## Mode Selection

Choose one mode automatically. If the request spans several modes, pick the
smallest mode that can answer the product decision.

- **Quick Assessment**: Fast verdict on one idea, request, or initiative. Use
  when the user asks for a quick take, second opinion, "worth it?", "should we",
  or "what is the next step?"
- **Current Product Assessment**: Evaluate present product health and maturity
  before choosing the next investment. Use only for an explicit product lens,
  distinguish product evidence from technical readiness, state what artifacts
  cannot establish, and recommend the highest-value next investment.
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

For **Quick Assessment**, use a short path: identify the problem and who gains
value; compare today's workaround or a minimal alternative; recommend a next step
with material cost/uncertainty and a criterion for revisiting the decision. Lead
with the recommendation. Do not require the expanded workflow or a lens inventory.

For deeper decisions in other modes, use the expanded sequence as relevant:

1. Restate the product problem or assessment question before evaluating solutions.
2. Identify who receives value and who pays the cost.
3. Describe how the problem is solved today.
4. If an initiative is proposed, test whether it solves the problem. Otherwise,
   identify the strongest evidence-backed product constraint.
5. Compare the current course, smallest useful change, broader or proposed
   investment, and a validation path when evidence is weak.
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

## Relevant Analysis Lenses

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

Product approval establishes a decision and its scope; it does not by itself authorize implementation or external publication. Carry accepted scope, non-goals, constraints, and success criteria into later phases without silently expanding or reopening them. Implement only when the user's request separately authorizes the concrete changes.

After a product decision:

- If architecture risk is material, hand off to `engineering-architecture` with
  the selected product scope, non-goals, constraints, and success criteria.
- If a concrete implementation or change request needs review, hand off to
  `engineering-code-review` with the accepted scope and success criteria.
- If the next step is implementation, testing, validation, PR work, or issue
  preparation, hand off to `engineering-delivery`.
- If the decision is to run a pilot, define pilot success gates before any build
  work.
- If the decision is to defer or reject, specify the evidence that would reopen
  the decision.
