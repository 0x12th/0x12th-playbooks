# Skill Selection

Select the skill from the user's intent, not from broad repository context.

Use the strict decision chain when multiple layers are needed:

```text
product-evolution
↓
engineering-architecture
↓
engineering-delivery
```

## Product Evolution

Use `product-evolution` only when the user explicitly invokes it or names this skill.

Use it when the user asks:

```text
What is the highest-value product investment?
```

Use for:

- Product investment decisions
- Customer request evaluation
- MVP boundaries
- Pilot evaluation
- Opportunity analysis
- Roadmap priority decisions
- Priority arbitration
- What not to do

Do not use automatically for generic product, roadmap, feature, customer request, architecture, or delivery requests.

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
- Technical evolution
- Design challenge
- Decision support
- Implementation planning before coding

Do not use for product investment decisions or direct code changes.

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

Do not use for product or architecture decisions. If implementation requires one of those decisions, state the missing decision before delivery work continues.

## Examples

| User request | Skill |
|---|---|
| `Use product-evolution. Should we build this feature?` | `product-evolution` |
| `Use product-evolution. Which should come first: mobile app or watch notifications?` | `product-evolution` |
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

Generic project-level prompts should normally use `engineering-architecture` in Quick Scan mode, unless the user explicitly asks to implement, test, fix, review a diff, or use `product-evolution`.

Examples:

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `What would you improve?` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Critique the architecture.` | `engineering-architecture` | Quick Scan or Focused Review + Architecture Quality |
| `Use product-evolution. What should this product become?` | `product-evolution` | Opportunity Analysis |
| `Use product-evolution. Create a future roadmap.` | `product-evolution` | Roadmap Planning |

## Selected Context

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

If the user selected a local code path and asks for a fix, choose `engineering-delivery`.

If the user selected a local design or migration plan and asks whether it is a good idea, choose `engineering-architecture`.

Do not broaden a local request into a full repository review unless the user asks for one.
