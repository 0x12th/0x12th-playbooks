# Example: Quick Scan

Prompt:

```text
Do a quick scan of this repository and return only the top 3–5 architecture findings.
```

Example output:

```md
1. API handlers own persistence details
   Severity: High
   Impact: Changes to storage schema force changes across request handling code, increasing regression risk and slowing feature delivery.
   Evidence: Multiple route handlers construct SQL queries directly and duplicate transaction handling.
   Minimal fix: Introduce a small repository or domain-service boundary for the highest-change aggregate first; do not rewrite all handlers at once.

2. Migration rollback path is unclear
   Severity: High
   Impact: A failed deployment could leave the database in a partially migrated state with no safe rollback or roll-forward procedure.
   Evidence: Migration files exist, but deployment docs do not describe rollback, compatibility, or verification.
   Minimal fix: Add a migration checklist covering backward-compatible schema changes, expand/contract rollout, and post-deploy verification.

3. Queue backlog is not observable
   Severity: Medium
   Impact: Worker failures or slow consumers may only be detected after user-facing delays appear.
   Evidence: Worker code logs failures, but no metrics or alert thresholds are documented.
   Minimal fix: Add queue depth, oldest message age, retry count, and dead-letter metrics before changing worker architecture.
```
