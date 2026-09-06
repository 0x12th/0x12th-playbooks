# Decision Model

Use this document for non-trivial product investment decisions, especially when
several initiatives compete for roadmap capacity.

## Default Comparison

Always compare:

1. Current state or do nothing.
2. Smallest useful change.
3. Proposed initiative.
4. Pilot or manual validation path.

Prefer the smallest path that captures most of the value with materially lower
effort, support load, and opportunity cost.

## Decision Outcomes

Use one of these outcomes:

| Outcome | Use when |
|---|---|
| `Do` | Value is material, usage likelihood is high, effort is acceptable, and timing matters. |
| `Do Smaller` | The problem is real, but the proposed scope is larger than needed. |
| `Pilot First` | Value could be real, but adoption, willingness to pay, workflow fit, or implementation risk is unproven. |
| `Defer` | The idea may be useful, but timing, dependency, evidence, or opportunity cost is unfavorable. |
| `Do Not Do` | Problem is weak, segment is too small, usage is unlikely, cost exceeds value, or it distracts from stronger priorities. |
| `Solve Differently` | The problem is valid, but a non-feature, manual, operational, partner, documentation, pricing, onboarding, or support change is better. |

## Evidence-Based Ranking

Compare user pain, segment value, business impact, usage likelihood, confidence,
implementation effort, ongoing support and maintenance load, strategic fit, and
cost of delay. Rank initiatives by explaining the decisive tradeoff and the
evidence that could reverse the order, not by a universal formula or point scale.

Calculate real costs and expected effects when data supports them; keep units,
assumptions, and uncertainty explicit. If the team has an accepted scoring model,
use its definitions and explain its limits rather than inventing a replacement.
When evidence is qualitative, use relative comparisons without numeric totals.

## Priority Arbitration

Use this comparison when two or more initiatives compete for the same capacity:

| Dimension | Question |
|---|---|
| Expected value | What user, customer, or business value is likely if this wins? |
| Cost | What delivery, maintenance, support, and coordination cost does it create? |
| Risk | What product, technical, operational, or adoption risk exists? |
| Urgency | What makes this time-sensitive? |
| Roadmap impact | What current roadmap commitment does it advance or displace? |
| Customer impact | Which customers benefit or suffer if it is chosen or delayed? |
| Team impact | Does it reduce or increase team load, focus, morale, or execution risk? |
| Cost of delay | What gets worse if this waits one cycle, one quarter, or longer? |

The recommendation should identify the winner, what loses, why that tradeoff is
acceptable, and what evidence would reverse the decision.

## Required Tradeoff Statement

For each recommendation, answer:

- What do we gain?
- What do we pay?
- What alternative are we delaying?
- What evidence would change the decision?

## Roadmap Placement

Use these roadmap buckets:

- `Now`: should compete for current cycle capacity.
- `Next`: promising but should wait behind current commitments.
- `Later`: keep as a known opportunity, not active work.
- `Parking Lot`: revisit only if new evidence appears.
- `Do Not Track`: remove from roadmap unless the market/customer situation changes.

If the existing roadmap is unknown, say the placement is conditional and name the
kind of current priority that would outrank it.
