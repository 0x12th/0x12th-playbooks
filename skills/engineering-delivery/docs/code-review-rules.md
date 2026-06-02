# Code Review Rules

Use code review mode when the user asks to review selected code, a diff, a commit, or a PR.

Focus on delivery risk:

- Bugs
- Behavioral regressions
- Missing or weak tests
- Data correctness issues
- Error handling gaps
- Compatibility breaks
- CI or validation gaps
- Security concerns when visible in the changed code

Do not turn code review into a broad architecture audit. If the review reveals a major architecture decision, flag it as a blocking design question and recommend `engineering-architecture-review`.

## Scope

Review the selected code or changed files first.

Expand only to direct callers, callees, tests, contracts, or configuration needed to verify the risk.

## Output

Lead with findings ordered by severity.

For each finding, include:

- Severity
- File or code reference
- Problem
- Impact
- Suggested fix

If there are no findings, say that clearly and mention any validation or test gaps that remain.

Keep summaries secondary to findings.
