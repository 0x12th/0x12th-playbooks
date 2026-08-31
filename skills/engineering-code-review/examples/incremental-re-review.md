# Example: Incremental Re-review

Prompt:

```text
Re-review the updated PR. Compare it with the previous reviewed head and check the two open findings.
```

Example output:

```md
Verdict: Changes required

Scope:
- Target: same canonical PR and base repository as the previous review
- Snapshot: previous full head OID -> current full head OID; base OID unchanged
- Mode: Incremental Re-review
- Limitations: provider CI for the current head is still running

Resolved:

1. Empty identifier validation
   - The new guard rejects empty identifiers before persistence, and the added regression test executes that path.

Still open:

1. Retry can repeat a non-idempotent charge
   - Severity / disposition / confidence: high / blocking / high
   - Location: `src/payments/charge.py`, current retry branch
   - Evidence: current pinned head still retries after an ambiguous timeout without an idempotency key
   - Impact: one customer charge can be submitted twice
   - Fix direction: bind retries to an idempotency key or stop retrying ambiguous submissions

New findings:

1. None confirmed in the fix impact cones.

Unable to verify:

- Current provider CI has not completed for the new head, so its result cannot be inherited from the previous revision.

Coverage:
- Reviewed: changes since the previous head and impact cones of both attempted fixes
- Limited: current-head CI result
```

If lineage, base identity, or prior coverage had been incomplete, the correct behavior would be a full review rather than this incremental report.
