# Example: Selected Code Review

Prompt:

```text
Review only this selected function:

def completion_percent(done: int, total: int) -> int:
    return done * 100 // total
```

Example output:

```md
Verdict: Blocked by missing evidence

Scope:
- Target: exact selected function as supplied
- Snapshot: selected text captured before review
- Mode: Code Review
- Limitation: callers and the input contract were not provided

Questions / missing evidence:

1. Can `total` be zero?
   - Location: selected function, return expression
   - Evidence: if zero reaches this line, Python raises `ZeroDivisionError`
   - Why it matters: the code is safe only if the surrounding contract guarantees a positive denominator or intentionally exposes that exception
   - Evidence needed: the input contract or direct callers that establish the allowed range and expected empty-workload behavior

Validation:
- Local checks were not run; division-by-zero behavior is established by language semantics

Coverage:
- Reviewed: selected function
- Blocked: caller guarantees and expected behavior for an empty workload
```

The review names the observable risk without inventing whether zero is a valid domain input or declaring an unsupported blocker.
