# Selected Context Rules

Selected code, selected files, pasted snippets, explicitly named services, modules, files, migrations, or proposals take precedence over repository-wide exploration.

When selected context is provided:

1. Analyze the selected context first.
2. Keep findings local to the selected scope.
3. Expand only into direct dependencies needed to understand the selected context.
4. Do not turn a local question into a repository-wide architecture review.
5. Do not ignore selected code because broader architecture analysis is possible.

Selected context is enough for a focused review when it contains:

- The code or files the user asks about
- A proposed design or migration plan
- A specific module, service, path, or boundary
- A local implementation plan that needs architecture validation

Expand beyond selected context only when:

- A direct dependency materially affects the finding
- A claimed boundary cannot be evaluated without nearby callers or callees
- Migration, ownership, or data correctness depends on adjacent code
- The user asks for a broader review

If selected context is insufficient, state the missing evidence and keep the recommendation strength proportional to confidence.
