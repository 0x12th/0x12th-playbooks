# Selected Context Rules

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

A dirty worktree is not selected context. Only selected code, named files, pasted snippets, or explicit diff, PR, or commit review requests should trigger code review mode.

When selected context is provided:

1. Start with the selected context.
2. Keep the change local to the selected scope.
3. Expand only into direct dependencies required to make or validate the change.
4. Do not refactor unrelated code.
5. Do not ignore selected code because broader cleanup is possible.

If selected context conflicts with repository behavior, preserve the selected scope and state the conflict.

If the selected context is insufficient to implement safely, ask for the missing file or inspect only the minimal direct dependency.
