---
name: engineering-delivery
description: >-
  Use for engineering delivery: diagnosis, investigation, implementation,
  coding, bug fixes, tests, CI/runtime failures, validation, local refactoring,
  commit messages, MR/PR descriptions, PR preparation, and incremental improvements.
  Diagnostic questions and assessment-only requests stay read-only; an explicit requested outcome requiring
  project changes authorizes scoped edits when the target is clear. Do not use for
  assessment of concrete code artifacts or provider change requests,
  architecture decisions, service extraction strategy, migration strategy,
  platform evolution, production readiness, deployment readiness, release
  readiness, server/VPS fit, runtime resource assessment, current architecture
  assessment, target architecture assessment, capacity and scaling assessment,
  repository-wide technical assessment, product investment decisions, product
  prioritization, MVP
  decisions, or long-term tradeoff analysis.
---

# Engineering Delivery

Answer:

```text
What is the safest next delivery action?
```

This is a delivery playbook for diagnosing, investigating, validating, and only when explicitly requested, making bounded code changes while preserving user work and minimizing regression risk.

## Boundaries

Use for diagnosis, investigation, authorized implementation, tests, CI fixes,
local refactoring, validation, and commit/MR/PR text preparation.

Product investment and scope belong to `product-evolution`; technical design,
migration strategy and architecture/readiness decisions belong to
`engineering-architecture`. Review of selected code or concrete change sets
belongs to `engineering-code-review`.

When a product or architecture decision is required before delivery work can continue, stop and state the decision that is missing. Do not route, announce, or explain skill selection unless the user asks or the host runtime requires disclosure.

## Intent Detection

Default to read-only for diagnosis, diagnostic questions and assessment-only requests. Scoped edits are authorized when the user explicitly requests an outcome that requires project changes and the target is clear; permission depends on intent, not a closed verb list. Examples such as “доведи до рабочего состояния”, “сделай чтобы CI был зелёным” and “закончи задачу” can authorize necessary edits. Examples are not exhaustive. A polite request such as “Можешь исправить этот баг?” or “Can you fix this?” still authorizes scoped edits; grammatical question form is not a read-only gate. If the target or outcome is unclear, clarify before editing. Assessing whether files can be removed does not authorize deletion. Release preparation (“подготовь релиз”) is not permission to publish, push or perform destructive operations.

Drafting a commit message or MR/PR description is delivery text work, including
during coding or after review. It does not require a prior review, authorize a
commit/push/publication, or require code edits. Use the artifact rules below.

## Review and Implementation Phases

Use `engineering-code-review` for read-only review of selected code, files, diffs, patches, commits, branches, merge requests, pull requests, and existing comments on a concrete change.

For a mixed request to review and fix, complete the read-only evidence/findings phase against exact selected text or an immutable change snapshot first, then apply these delivery rules to authorized confirmed fixes in a bounded implementation phase. No runtime switch or handoff API is required. If required guidance is unavailable, disclose it and retain authorization, selected scope, user-work preservation and validation safeguards. Do not edit during review or treat optional suggestions as authorized fixes.

## Work Modes

Choose the smallest useful mode:

- **Diagnosis**: explain the failure, likely cause, and next safe action without editing files.
- **Investigation**: gather only the evidence needed to answer when selected context is insufficient.
- **Implementation**: make a bounded code or config change only when explicit user intent authorizes the required project changes.
- **Validation**: run checks, explain pass/fail results, and classify failures.

## Execution Discipline

Use the smallest safe execution loop:

1. Classify the mode: diagnosis, investigation, implementation, or validation.
2. Start from the strongest local evidence: selected context, stack traces, logs, failing tests, provided files, provided diffs, then named repository files.
3. For runtime failures, follow the traceback before exploring the repository. Traceback beats repository exploration.
4. In read-only modes, answer the question and stop when the evidence is sufficient.
5. In implementation mode, make the smallest behavior-preserving or behavior-targeted change and validate it.
6. Report only findings, changed files when applicable, validation result, remaining risk, and next safe step.

Do not broaden the task unless current evidence shows the selected scope is insufficient.

For a disputed regression, separate an old failure site from a new trigger. Compare baseline and changed behavior on the same inputs and controlled dependency responses when safe; do not alter the user's branch merely to isolate a check.

Do not fix unrelated issues discovered during the task. Mention them as follow-ups only when they materially affect the requested change.

Do not treat a change as complete without either validation or a clear explanation of why validation could not be run.

A declared setting or fixture is not an observed runtime effect: trace the executing path to its observable result and distinguish static inference from what was actually verified.

## Commit Messages and MR/PR Descriptions

Apply these rules whenever producing the artifact, not only in PR preparation.
Chat uses the request language. Artifact language follows explicit artifact
instructions, documented project rules, stable recent same-artifact history,
then request language. Surface conflicts with mandatory project policy; do not
silently bypass it. Historical casing or missing prefixes do not override the
defaults below. Preserve identifiers, acronyms and required machine tokens.

Default to `type(scope): description`, with optional scope and a type matching
the change (`fix` for bugs, `feat` for new capabilities). Begin the description
with a lowercase verb: Russian past-tense singular active without `я`, English
imperative. For example, `fix(api): исправил повторное создание задачи` or
`fix(api): prevent duplicate task creation`. Add a body only when it adds useful
context. These language/casing defaults are playbook preferences, not mandatory
Conventional Commits grammar.

Use one language for the MR/PR title, ordinary headings and body. Explain why the
change is needed, what changed and the important mechanism in plain language for
a colleague without prior context. Describe final behavior, not commit history
or an agent diary. State actual verification and material limits; omit empty
optional sections. Preserve exact project-required fields/markers. Load
`references/communication-rules.md` when available for calibration and details;
this core remains usable without it. Drafting does not authorize external actions.

## User-Visible Output Contract

Show the result, not the machinery.

The user should see only:

- current finding, conclusion, or decision;
- changed files, when files were changed;
- validation result;
- remaining risk;
- next safe action.

Do not expose:

- hidden reasoning or `<thinking>...</thinking>` blocks;
- tool calls, tool names, tool statuses, JSON payloads, command transcripts, or file-opening logs;
- skill contents, loaded reference documents, or long copied instruction blocks;
- repository traversal narration such as "I opened", "I searched", "I am checking", "I will inspect", or "I found these files";
- internal planning notes, routing notes, or comparison notes;
- raw diffs, full files, or large code blocks unless the user explicitly asks for them.

Use progress updates for long-running work or when required by the host or requested by the user. Keep them to one or two short sentences about useful state. Required host disclosures take precedence over these output preferences; do not add routine tool narration.

## Diff Output Policy

Do not paste raw git diffs, patches, or large changed-code blocks by default.

Before an authorized deletion, identify the exact targets and verify recovery
of their current contents, including staged, unstaged, or untracked changes.
Git tracking alone is not proof of recovery. If recovery cannot be established,
leave the file intact and ask for explicit consent to lose its current contents;
a generic deletion request is insufficient. Once recovery is verified, delete
without another confirmation and report how to recover the file.

Preserve and verify recovery without exposing sensitive or deleted contents.
Prefer a non-content-returning deletion operation when the host allows it, and
verify the result. When the host requires a content-returning edit, use it once
without repeating its payload. Load `references/code-change-rules.md` when
available for the detailed procedure; these safeguards also apply without it.

When reporting changes:

- summarize behavioral impact;
- list changed files only when useful;
- mention exact functions or paths when needed;
- quote only small snippets that are necessary as evidence;
- provide a patch or diff only when the user explicitly asks for raw diff, patch, or exact code changes.

## Risk Control

Prefer local, reversible changes.

Before editing shared contracts, public APIs, migrations, deployment configuration, CI pipelines, dependency versions, or generated files, verify that the change is required for the requested task. When a shared client changes how it reports errors, inspect affected callers, exception handlers, foreground/background paths, and existing fallbacks before claiming compatibility; do not invent a new recovery policy.

For destructive, broad, or hard-to-revert changes, explain the risk and choose a smaller step when possible.

Preserve user work. Do not overwrite unrelated changes.

## Optional Context Sources

Optional memory backends may be used only when already available through the project or agent runtime.

Do not consult memory before current local evidence. Use memory only as supplemental context for prior decisions, project conventions, or investigation history after selected context, repository files, code, tests, logs, diffs, validation results, and explicit user instructions have been checked.

Treat memory as unverified until supported by current evidence. Memory must not replace reproduction, inspection, tests, or validation, and must not broaden the investigation or change scope by itself.

Do not require, install, configure, or depend on a memory backend.

## Supporting References Loading

The runtime core above is the default execution contract. Do not load supporting references just because they exist.

Load supporting references only when the current task needs more detail:

- `references/communication-rules.md`: load when drafting commit messages, MR/PR titles or descriptions, release notes, engineering tickets, or other external-facing technical text; includes local style calibration and concise artifact rules. Also use for non-trivial output conflicts.
- `references/language-rules.md` and `references/selected-context-rules.md`: use for non-trivial language, selected-context, or scope conflicts; core principles are summarized above.
- `references/implementation-workflow.md`, `references/code-change-rules.md`, and `references/validation-rules.md`: load for medium- or high-risk implementation, shared contracts, public APIs, migrations, deployment configuration, CI pipelines, dependency versions, generated files, or when this core is insufficient to choose the safe change or validation path.
- `references/code-change-rules.md`: also load before file deletion or when choosing between a local refactor and a bounded rebuild from requirements/facts; neither authorizes an undecided architecture or product change.
- `references/testing-rules.md`: load for test or regression work.
- `references/python-testing-rules.md`: load with `references/testing-rules.md` for Python test or regression work.
- `references/validation-rules.md`: also load for disputed regression attribution or claims that a configured or fixture-driven runtime effect occurred.

Supporting templates:

- `templates/change-plan.md`
- `templates/pr-summary.md`

Examples:

- `examples/implementation.md`
- `examples/bug-fix.md`
- `examples/tests.md`
- `examples/ci-fix.md`
