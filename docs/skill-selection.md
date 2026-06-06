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
What is the safest next delivery action?
```

Use for:

- Diagnosis
- Investigation
- Implementation
- Bug fixes
- Tests
- CI fixes
- Local refactoring
- Validation
- PR preparation
- Incremental improvements

Default to read-only diagnosis for prompts such as `why is this happening`, `where is the problem`, `analyze this error`, `what changed`, `check this`, or `review this`.

Edit only when the user explicitly asks to implement, fix, patch, modify, update, refactor, or apply changes.

Do not use for architecture decisions. If implementation requires an architecture decision, state the missing decision before delivery work continues.

## Examples

| User request | Skill |
|---|---|
| `Should we merge two tightly coupled modules?` | `engineering-architecture-review` |
| `How should we start the merge step by step?` | `engineering-architecture-review` |
| `Implement the first merge step.` | `engineering-delivery` |
| `Review the service architecture.` | `engineering-architecture-review` |
| `Write tests.` | `engineering-delivery` |
| `Why is CI failing?` | `engineering-delivery` in read-only diagnosis mode |
| `Investigate this runtime exception.` | `engineering-delivery` in read-only diagnosis mode |
| `Should background jobs move to a different queue runtime?` | `engineering-architecture-review` |
| `Move the task handler to the already approved queue runtime.` | `engineering-delivery` |
| `Fix the failing CI test.` | `engineering-delivery` |
| `Review this PR.` | `engineering-delivery` in read-only review mode |
| `Review this PR for bugs and missing tests.` | `engineering-delivery` in read-only review mode |

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
