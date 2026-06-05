# Skill Selection

Select the skill from the user's intent, not from broad repository context.

## Engineering Architecture Review

Use `engineering-architecture-review` when the user asks:

```text
How should the system be designed?
```

Use for:

- Architecture decisions
- Migrations and migration review
- Service boundaries
- Domain boundaries
- Ownership and data ownership
- Architecture debt
- Reliability strategy
- Observability architecture
- Deployment architecture
- System evolution
- Design challenge
- Decision support
- Implementation planning before coding

Do not use for direct code changes.

## Engineering Delivery

Use `engineering-delivery` when the user asks:

```text
How should this change be implemented safely?
```

Use for:

- Implementation
- Bug fixes
- Tests
- CI fixes
- Local refactoring
- Validation
- PR preparation
- Incremental improvements

Do not use for architecture decisions. If implementation requires an architecture decision, recommend architecture review first.

## Examples

| User request | Skill |
|---|---|
| `Should we merge two tightly coupled modules?` | `engineering-architecture-review` |
| `How should we start the merge step by step?` | `engineering-architecture-review` |
| `Implement the first merge step.` | `engineering-delivery` |
| `Review the service architecture.` | `engineering-architecture-review` |
| `Write tests.` | `engineering-delivery` |
| `Why is CI failing?` | `engineering-delivery` |
| `Should background jobs move to a different queue runtime?` | `engineering-architecture-review` |
| `Move the task handler to the already approved queue runtime.` | `engineering-delivery` |
| `Review this PR for bugs and missing tests.` | `engineering-delivery` |

## Generic Project Prompts

Generic project-level prompts should normally use `engineering-architecture-review` in quick scan mode, unless the user explicitly asks to implement, test, fix, or review a diff.

Examples:

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture-review` | Quick scan |
| `What would you improve?` | `engineering-architecture-review` | Quick scan |
| `Critique the architecture.` | `engineering-architecture-review` | Quick scan or focused architecture critique |

## Selected Context

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

If the user selected a local code path and asks for a fix, choose `engineering-delivery`.

If the user selected a local design or migration plan and asks whether it is a good idea, choose `engineering-architecture-review`.

Do not broaden a local request into a full repository review unless the user asks for one.
