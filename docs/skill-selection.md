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
| `Стоит ли объединять два сильно связанных модуля?` | `engineering-architecture-review` |
| `Как по шагам начать объединение?` | `engineering-architecture-review` |
| `Реализуй первый шаг объединения.` | `engineering-delivery` |
| `Посмотри архитектуру сервиса.` | `engineering-architecture-review` |
| `Напиши тесты.` | `engineering-delivery` |
| `Почему падает CI?` | `engineering-delivery` |
| `Стоит ли переносить фоновые задачи на другой runtime очередей?` | `engineering-architecture-review` |
| `Переведи обработчик задачи на уже выбранный runtime очередей.` | `engineering-delivery` |
| `Проверь PR на баги и пропущенные тесты.` | `engineering-delivery` |

## Generic Project Prompts

Generic project-level prompts should normally use `engineering-architecture-review` in quick scan mode, unless the user explicitly asks to implement, test, fix, or review a diff.

Examples:

| User request | Skill | Mode |
|---|---|---|
| `Посмотри проект.` | `engineering-architecture-review` | Quick scan |
| `Что бы ты улучшил?` | `engineering-architecture-review` | Quick scan |
| `Прожарь архитектуру.` | `engineering-architecture-review` | Quick scan or focused architecture critique |
| `Look at this project.` | `engineering-architecture-review` | Quick scan |
| `What would you improve?` | `engineering-architecture-review` | Quick scan |
| `Critique the architecture.` | `engineering-architecture-review` | Quick scan or focused architecture critique |

## Selected Context

Selected code, selected files, pasted snippets, or explicitly named files take precedence over repository-wide exploration.

If the user selected a local code path and asks for a fix, choose `engineering-delivery`.

If the user selected a local design or migration plan and asks whether it is a good idea, choose `engineering-architecture-review`.

Do not broaden a local request into a full repository review unless the user asks for one.
