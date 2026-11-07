# MR/PR Description Guide

Apply the delivery artifact-language rules. This guide is not literal output:
translate ordinary headings and placeholders into the chosen artifact language,
keep project-mandated fields or exact machine markers, and omit empty sections.

For a small change, use a title and a few paragraphs:

```text
[Outcome title; use commit formatting if the title becomes a squash commit]

[Problem, relevant context and why this change is needed.]

[What now happens and the important part of how it works.]

[Actual verification and any material unverified limit.]
```

For a larger change, optional headings may separate context, changes and checks.
Add migration/compatibility/risk information only when relevant or required.
Avoid commit-log dumps, file inventories, duplicate summaries and boilerplate.
Never copy example checks as if they ran. This guide does not authorize a commit,
push, or MR/PR publication.
