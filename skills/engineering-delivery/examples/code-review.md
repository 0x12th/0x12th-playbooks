# Example: Code Review

Prompt:

```text
Review this PR.
```

Example output:

```md
Verdict: Changes required

Blocking findings:

1. Missing validation for empty input
   Severity: High
   File: `src/commands/run_job.py`
   Problem: The new command path accepts an empty job id and passes it to the runner.
   Impact: Invalid requests can create failed jobs that are hard to reconcile.
   Suggested fix: Reject empty job ids before creating the job record and add a regression test.

Validation gaps:

- No coverage is visible for invalid input or runner failure.

Optional improvements:

1. Rename the local runner helper
   File: `src/commands/run_job.py`
   Problem: The helper name is broader than its current responsibility.
   Impact: Readability only; this does not block delivery.
   Suggested fix: Consider a focused rename in a separate change.
```
