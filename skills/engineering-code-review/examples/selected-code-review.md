# Example: Selected Code Review

Prompt:

```text
Review only this selected function:

def completion_percent(done: int, total: int) -> int:
    return done * 100 // total
```

Example output:

```md
Verdict: Changes required

Scope:
- Target: exact selected function as supplied
- Snapshot: selected text captured before review
- Mode: Code Review
- Limitations: callers and input contract were not provided

Blocking findings:

1. Zero totals crash instead of producing domain behavior
   - Severity / disposition / confidence: medium / blocking / high
   - Location: selected function, return expression
   - Evidence: inferred directly from the pinned selection; `total == 0` reaches integer division
   - Problem: the function accepts any integer but does not guard the zero denominator
   - Trigger: `completion_percent(0, 0)`
   - Impact: callers receive `ZeroDivisionError` on an empty workload
   - Fix direction: define the empty-total contract and reject or handle zero before division
   - Attribution / discussion: introduced by the selected implementation; no discussion evidence available

Validation:
- Local checks were not run; the failure is established by language semantics

Coverage:
- Reviewed: selected function
- Limited: caller expectations and repository error-handling convention
```

The review stays inside selected context and names the missing contract without inventing repository behavior.
