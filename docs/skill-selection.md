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

Use `product-evolution` when the user's primary question is product value, scope, priority, MVP, customer request evaluation, roadmap sequencing, or whether something should be built. Explicit invocation is allowed but not required.

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

Do not use for implementation, debugging, architecture design, migration strategy, CI, tests, coding tasks, production readiness, deployment readiness, server/VPS fit, or runtime resource review.

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
- Production readiness
- Deployment readiness
- Release readiness
- Operational readiness
- Runtime resource review
- VPS/server fit assessment
- Current architecture assessment
- Target architecture assessment
- Capacity and scaling review
- Repository-wide technical review
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
| `Should we build this feature?` | `product-evolution` |
| `Is this worth doing?` | `product-evolution` |
| `Do we need this feature?` | `product-evolution` |
| `What is the MVP?` | `product-evolution` |
| `What is the smallest useful solution?` | `product-evolution` |
| `What should come first?` | `product-evolution` |
| `A customer asked for X. Should we do it?` | `product-evolution` |
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

Generic project-level technical prompts should normally use `engineering-architecture`, not `engineering-delivery`, unless the user explicitly asks to implement, test, fix, validate a selected change, review a diff, review a PR, or diagnose a specific failure.

Product-value prompts use `product-evolution`.

Examples:

| User request | Skill | Mode |
|---|---|---|
| `Look at this project.` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Review this project.` | `engineering-architecture` | Quick Scan or Full Review + Architecture Quality |
| `What would you improve?` | `engineering-architecture` | Quick Scan + Architecture Quality |
| `Critique the architecture.` | `engineering-architecture` | Quick Scan or Focused Review + Architecture Quality |
| `Is it ready for production?` | `engineering-architecture` | Deployment Readiness Review |
| `Can I deploy this to a VPS?` | `engineering-architecture` | Deployment Readiness Review |
| `Is it ready for an update?` | `engineering-architecture` | Deployment Readiness Review |
| `What is the current architecture?` | `engineering-architecture` | Full Review + Architecture Quality |
| `What should the target architecture be?` | `engineering-architecture` | Full Review + Technical Evolution |
| `What should this product become?` | `product-evolution` | Opportunity Analysis |
| `Create a future roadmap.` | `product-evolution` | Roadmap Planning |
| `Review this PR.` | `engineering-delivery` | Review |
| `Why is CI failing?` | `engineering-delivery` | Diagnosis |

## Selected Context

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

If the user selected a local code path and asks for a fix, choose `engineering-delivery`.

If the user selected a local design or migration plan and asks whether it is a good idea, choose `engineering-architecture`.

Do not broaden a local request into a full repository review unless the user asks for one.
