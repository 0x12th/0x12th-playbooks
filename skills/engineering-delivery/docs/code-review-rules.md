# Code Review Rules

Use code review mode when the user asks to review selected code, a diff, a commit, or a PR.

Code review is read-only unless the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

Focus on delivery risk:

- Bugs
- Behavioral regressions
- Missing or weak tests
- Data correctness issues
- Error handling gaps
- Compatibility breaks
- CI or validation gaps
- Security concerns when visible in the changed code

Do not turn code review into a broad architecture audit. If the review reveals a major architecture decision, flag it as a blocking design question.

## Scope

Review the selected code or changed files first.

Expand only to direct callers, callees, tests, contracts, or configuration needed to verify the risk.

Stop expanding when the finding is supported, when additional exploration is unlikely to change severity or recommendation, or when the remaining uncertainty can be stated directly.

## Diff Handling

Do not dump raw git diffs by default.

When reviewing changes:

- Summarize behavioral impact.
- Explain only changes relevant to findings, validation gaps, or user questions.
- Quote specific lines only when necessary as evidence.
- Require an explicit user request before returning a large raw diff.

## Finding Discipline

- Findings must be grounded in changed code, selected code, tests, logs, configuration, or direct dependencies.
- Prefer one well-supported root-cause finding over several symptoms of the same defect.
- If a repeated defect pattern appears, recommend a shared test, lint rule, validator, or helper only when it would prevent recurrence with modest complexity.
- Do not assert production impact, scale, ownership, or user behavior that is not visible from the evidence.
- Keep confidence proportional to evidence. Mark uncertain findings as questions or missing evidence rather than defects.

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
