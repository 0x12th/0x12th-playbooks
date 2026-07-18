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

Begin with exactly one verdict:

- **Pass:** no confirmed defect blocks delivery.
- **Changes required:** at least one confirmed defect blocks delivery.
- **Blocked by missing evidence:** the available evidence cannot support a safe verdict.

After the verdict, include only non-empty sections that help the user act:

1. Blocking findings
2. Non-blocking findings
3. Validation gaps
4. Optional improvements

Order findings by severity inside each findings section. Do not mix confirmed defects with optional design, naming, cleanup, or refactoring ideas. Do not print empty sections.

For each finding, include:

- Severity
- File or code reference
- Problem
- Impact
- Suggested fix

If there are no findings, say that clearly and mention any validation or test gaps that remain.

Keep summaries secondary to the verdict and findings.

## External Recommendation Audit

When the user provides external review comments or recommendations and asks whether they are valid, verify each premise and classify each recommendation as:

- **Correct**
- **Correct but optional**
- **Incorrect**
- **Already addressed**
- **Invalid premise**

Give a concise evidence-based rationale for each classification. Use missing evidence to limit confidence instead of accepting or rejecting a recommendation speculatively.

This is conditional review behavior, not a separate work mode. Do not use this classification table for an ordinary code, diff, commit, or PR review.
