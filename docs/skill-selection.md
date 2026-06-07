# Skill Selection

Select the skill from the user's intent, not from broad repository context.

## Engineering Architecture

Use `engineering-architecture` when the user asks:

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
- Product evolution
- Roadmap planning
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
| `Should we merge two tightly coupled modules?` | `engineering-architecture` |
| `How should we start the merge step by step?` | `engineering-architecture` |
| `Implement the first merge step.` | `engineering-delivery` |
| `Review the service architecture.` | `engineering-architecture` |
| `Write tests.` | `engineering-delivery` |
| `Why is CI failing?` | `engineering-delivery` in read-only diagnosis mode |
| `Investigate this runtime exception.` | `engineering-delivery` in read-only diagnosis mode |
| `Should background jobs move to a different queue runtime?` | `engineering-architecture` |
| `Move the task handler to the already approved queue runtime.` | `engineering-delivery` |
| `Fix the failing CI test.` | `engineering-delivery` |
| `Review this PR.` | `engineering-delivery` in read-only review mode |
| `Review this PR for bugs and missing tests.` | `engineering-delivery` in read-only review mode |

## Generic Project Prompts

Generic project-level prompts should normally use `engineering-architecture` in Quick Scan mode, unless the user explicitly asks to implement, test, fix, or review a diff. If the same repository-wide or project-wide review asks about future features, product opportunities, broader usage, roadmap, scaling, migration, or product evolution, select Full Review + Product Evolution by default.

Do not infer Focused Review from examples of desired product growth. In broad project or repository reviews, treat named features as evolution drivers inside Full Review unless the user asks to focus only on them.

Examples:

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `What would you improve?` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Critique the architecture.` | `engineering-architecture` | Quick Scan or Focused Review + Architecture Quality |
| `Review this project. What can it become?` | `engineering-architecture` | Full Review + Product Evolution |
| `Create a future roadmap.` | `engineering-architecture` | Full Review + Product Evolution |

## Selected Context

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

If the user selected a local code path and asks for a fix, choose `engineering-delivery`.

If the user selected a local design or migration plan and asks whether it is a good idea, choose `engineering-architecture`.

Do not broaden a local request into a full repository review unless the user asks for one.
