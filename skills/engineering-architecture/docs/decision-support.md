# Decision Support

Use this mode when the user asks whether to choose, merge, split, migrate, replace, introduce, or avoid something.

Answer the decision directly.

## Required Comparison

For every major architecture decision, compare:

1. **Do nothing:** keep the current state and accept known cost or risk.
2. **Minimal change:** make the smallest intervention that addresses the material problem.
3. **Proposed change:** implement the submitted architecture, migration, extraction, redesign, or replacement.

Apply this especially to:

- Service extraction
- Service consolidation
- Database redesign
- Event-driven architecture
- Queue or task framework migration
- Language/runtime migration
- Infrastructure replacement
- Platform evolution

## Validate the Problem

Do not assume the proposed solution is needed.

Validate:

- The problem exists.
- The problem is material.
- The proposed change addresses the root cause.
- The expected benefit is worth the cost.

It is valid to recommend:

- No change
- Postponement
- More evidence
- A smaller local intervention

## Output

Use a decision-oriented structure:

1. Recommendation
2. Why
3. Options compared
4. Cost and risk comparison
5. Conditions that would change the recommendation
6. Confidence

Keep implementation planning separate. If the user asks for the first implementation step, provide an implementation plan only, not code changes.
