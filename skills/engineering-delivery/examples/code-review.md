# Example: Code Review

Prompt:

```text
Use engineering-delivery.

Review this PR for bugs, regressions, and missing tests.
```

Example output:

```md
Findings:

1. Missing validation for empty input
   Severity: High
   File: `src/commands/run_job.py`
   Problem: The new command path accepts an empty job id and passes it to the runner.
   Impact: Invalid requests can create failed jobs that are hard to reconcile.
   Suggested fix: Reject empty job ids before creating the job record and add a regression test.

2. Test only covers the success path
   Severity: Medium
   File: `tests/test_run_job.py`
   Problem: The added test verifies a valid job but not invalid input or runner failure.
   Impact: The behavior most likely to regress is not protected.
   Suggested fix: Add tests for invalid input and runner exceptions.

Validation gap:

- No coverage is visible for the failure path introduced by this change.
```
