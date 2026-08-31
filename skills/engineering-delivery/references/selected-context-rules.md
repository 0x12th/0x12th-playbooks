# Selected Context Rules

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

A dirty worktree is not selected context. Review of selected code, diffs, patches, commits, branches, merge requests, or pull requests belongs to `engineering-code-review`; this reference governs selected evidence for delivery diagnosis, investigation, implementation, and validation.

Evidence priority:

1. Selected context and explicit user instructions.
2. Stack traces, runtime exceptions, logs, and failing test output.
3. Provided files, patches, named files, commits, or change-request context needed for the delivery task.
4. Direct callers, callees, tests, schemas, configuration, or CI definitions.
5. Broader repository exploration only when the earlier evidence is insufficient.

When selected context is provided:

1. Start with the selected context.
2. Keep diagnosis, investigation, validation, or implementation local to the selected scope.
3. Expand only into direct dependencies required to answer the question or validate the change.
4. Stop exploring when sufficient evidence already exists.
5. Do not refactor unrelated code.
6. Do not ignore selected code because broader cleanup is possible.

If selected context conflicts with repository behavior, preserve the selected scope and state the conflict.

If the selected context is insufficient to implement safely, ask for the missing file or inspect only the minimal direct dependency.
