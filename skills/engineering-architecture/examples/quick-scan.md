# Example: Quick Scan

Prompt:

```text
Do a quick scan of this repository and return only the top 3–5 architecture findings.
```

Example output:

```md
Verdict: Keep the current architecture. Storage coupling has a local improvement path; migration recovery and queue observability need evidence before deciding on further changes.

1. API handlers own persistence details
   Severity: High
   Confidence: Medium
   Impact: Changes to storage schema force changes across request handling code, increasing regression risk and slowing feature delivery.
   Evidence: Multiple route handlers construct SQL queries directly and duplicate transaction handling.
   Minimal fix: Introduce a small repository or domain-service boundary for the highest-change aggregate first; do not rewrite all handlers at once.
   Disposition: Next safe step.

2. Migration recovery is unverified
   Severity: High
   Confidence: Low; recovery outside the repository has not been checked.
   Impact: If no usable recovery path exists, a failed deployment could leave the database in a partially migrated state.
   Evidence: Migration files exist, but deployment docs do not describe rollback, compatibility, or verification.
   Minimal action: Check the actual rollout/recovery procedure and its rehearsal evidence; address a missing recovery path only if confirmed.
   Validation signal: A verified rollback or roll-forward path for the planned schema change.
   Disposition: Defer pending evidence.

3. Queue observability coverage is unverified
   Severity: Medium
   Confidence: Low; broker and infrastructure monitoring were not inspected.
   Impact: If backlog and retry signals are absent, worker failures or slow consumers may only be detected after user-facing delays appear.
   Evidence: Worker code logs failures, but no metrics or alert thresholds are documented.
   Minimal action: Inspect existing broker metrics and monitoring views; propose only signals confirmed missing from the effective setup.
   Validation signal: Queue backlog, age, and failure trends can be checked through the existing or proposed monitoring.
   Disposition: Defer pending evidence.
```
