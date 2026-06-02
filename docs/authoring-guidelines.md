# Authoring Guidelines

These guidelines keep skills useful for AI coding agents without increasing context cost unnecessarily.

## Principles

- Keep `SKILL.md` concise.
- Load detailed instructions on demand.
- Make boundaries explicit.
- Prefer intent detection over broad activation.
- Give selected context priority.
- Define exploration budgets and stop conditions.
- Use confidence gates for recommendation strength.
- Decide before implementation.
- Prefer evidence-first reasoning.
- Avoid process narration in final outputs.

## Skill Entry Points

`SKILL.md` should contain:

- Purpose
- Boundaries
- Intent detection
- Mode or work selection
- References to supporting documents

Do not put the full playbook in `SKILL.md`.

## Supporting Docs

Docs should be directly linked from `SKILL.md`. Avoid deep reference chains.

Use docs for:

- Mode-specific behavior
- Communication rules
- Selected-context rules
- Exploration budgets
- Validation rules
- Testing rules
- Decision frameworks
- Economics and tradeoff models

## Avoid Overengineering

Prefer:

- Deletion over abstraction.
- Consolidation over service extraction.
- Local improvement over redesign.
- Evidence over architectural fashion.

Do not create new skills, manifests, templates, or docs unless they support a real agent behavior.

## Repository Scope

This repository is a playbook and skill library. It is not an agent framework.

Do not add runtime harnesses, orchestration systems, prompt chains, or tool frameworks unless there is a clear product direction and real usage need.
