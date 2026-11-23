# Independent Review Packet

Use with `engineering-code-review` Code Review for a fresh delivery reviewer.
Fill applicable fields with factual evidence and accessible source references.

## Assignment

- Role: general review | focused simplicity/integration review.
- Review target and requested scope:
- For focused review, the concrete structural decision to examine:

## Accepted Task and Design

- Original task and accepted requirements:
- Accepted constraints, design decisions, and material rationale:
- Relevant repository instructions and authoritative contracts:
- Unresolved requirement conflicts or known evidence gaps:

## Immutable Snapshot

- Repository/source identity and resolved full base OID or exact equivalent:
- Delivered snapshot identifier, including full head OID when applicable:
- Captured selection and contents of staged, unstaged, and untracked feature changes:
- Excluded unrelated local work:
- Immutable source location and complete feature diff from the resolved base:
- Relevant dependency source paths, versions, and permitted read access:
- Snapshot protection or captured-content identifiers proving the reviewed state:

Include the whole feature, not only the latest commit or the last edited files.
Keep source and dependency evidence fixed while the reviewer works. Report
missing material content as a coverage limit. If selected contents change, stop
until a complete snapshot is pinned again.

## Validation Evidence

- Checks actually performed, commands or check identities, and results:
- Snapshot each result covers, including CI run/revision when available:
- Relevant environment limits, checks not run, and remaining uncertainty:

## Reviewer Instructions

Review independently using the skill's evidence, safety, and finding rules.
The general reviewer covers requirements, correctness, integration, and
simplicity. The focused reviewer examines the assigned decision and its impact
cone; that scope cannot establish a whole-feature pass.

Keep the first pass free of the author's implementation conversation,
self-assessment, and other reviewers' findings. Preserve accepted task and
design rationale as evidence. Stay read-only and do not spawn further reviewers.

Support each finding with exact location, trigger or maintenance consequence,
evidence, and minimal remedy. A simplification must offer a viable smaller option,
preserve constraints and responsibilities, and account for change cost and risk.
Zero findings is valid. Distinguish defects, optional improvements, and unknowns.

## Return

Use the existing review report: scoped verdict, findings, validation, and coverage.
Delivery reconciles independent results into one report and audits recommendations.
