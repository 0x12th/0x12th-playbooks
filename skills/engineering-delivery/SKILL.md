---
name: engineering-delivery
description: >-
  Use for safe engineering delivery work: diagnosis, investigation,
  implementation, coding, bug fixes, tests, CI failures, runtime failures,
  validation, local refactoring, PR preparation, and incremental improvements.
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

Applies to:

- Diagnosis
- Investigation
- Implementation
- Coding tasks
- Bug fixes
- Tests
- CI fixes
- Local refactoring
- Validation
- PR preparation
- Incremental improvements

Does not apply to:

- Product investment decisions
- Product prioritization
- MVP decisions
- Architecture decisions
- Service extraction strategy
- Migration strategy
- Platform evolution
- Production readiness
- Deployment readiness
- Release readiness
- Server/VPS fit assessment
- Runtime resource review
- Current architecture assessment
- Target architecture assessment
- Capacity and scaling review
- Repository-wide technical review
- Project readiness review
- Long-term tradeoff analysis
- Broad architecture assessment
- Read-only review of selected code or concrete change sets; use `engineering-code-review`

When a product or architecture decision is required before delivery work can continue, stop and state the decision that is missing. Do not route, announce, or explain skill selection unless the user asks or the host runtime requires disclosure.

## Intent Detection

Default to read-only for diagnosis, diagnostic questions and assessment-only requests. Scoped edits are authorized when the user explicitly requests an outcome that requires project changes and the target is clear; permission depends on intent, not a closed verb list. Examples such as “доведи до рабочего состояния”, “сделай чтобы CI был зелёным” and “закончи задачу” can authorize necessary edits. Examples are not exhaustive. A polite request such as “Можешь исправить этот баг?” or “Can you fix this?” still authorizes scoped edits; grammatical question form is not a read-only gate. If the target or outcome is unclear, clarify before editing. Assessing whether files can be removed does not authorize deletion. Release preparation (“подготовь релиз”) is not permission to publish, push or perform destructive operations.

Read-only diagnosis, investigation, or validation examples:

- "Why is CI failing?"
- "Analyze this error."
- "Look at this selected log or error."
- "Check this failure or validation result."
- "Where is the problem?"
- "Is this related?"
- "Investigate this runtime exception."
- "Validate this change."

Implementation examples:

- "Implement the first merge step."
- "Write tests."
- "Move this job to the approved queue runtime."
- "Fix this bug."
- "Fix the failing CI test."
- "Patch this failure."
- "Refactor this function."
- "Prepare the PR summary."

Architecture examples that require a decision before delivery work:

- "Review this project."
- "What should I improve?"
- "Is this ready for production?"
- "Can I deploy this to a VPS?"
- "Is this ready for an update?"
- "What is the current architecture?"
- "What should the target architecture be?"
- "Review deployment readiness."
- "Review runtime resources."
- "Will this fit on this server?"
- "What are the scaling risks?"
- "Should we merge these services?"
- "Should background jobs move to a different queue runtime?"
- "What should the service boundary be?"
- "Review this migration strategy."
- "Challenge this design."

For these prompts, do not begin delivery investigation. State the missing architecture/readiness decision first.

Product examples that require a decision before delivery work:

- "Should we build this feature?"
- "What is the MVP?"
- "Which priority should come first?"
- "Should this customer request become roadmap work?"

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

Do not fix unrelated issues discovered during the task. Mention them as follow-ups only when they materially affect the requested change.

Do not treat a change as complete without either validation or a clear explanation of why validation could not be run.

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

Progress updates are allowed only when the task is long-running. They must be one or two short sentences and must summarize useful state, not actions of the agent.

Bad progress update:

```text
I will inspect the repository, read SKILL.md, then open the docs and run validation.
```

Good progress update:

```text
The likely issue is in the delivery skill: implementation tasks still allow noisy progress narration. I am tightening that contract and keeping the change local.
```

Bad final report:

```text
Tool Call: Read file...
Status: Completed
<thinking>...</thinking>
```

Good final report:

```text
Changed `skills/engineering-delivery/SKILL.md`.
Validation: not run; markdown-only instruction change.
Remaining risk: other external skills may still print tool traces unless they have the same output contract.
```

## Diff Output Policy

Do not paste raw git diffs, patches, or large changed-code blocks by default.

Before deletion, resolve exact authorized targets and inspect existence,
metadata, and version-control status without exposing file contents. A tracked
path is not a recovery guarantee: Git may retain an older version, not current
staged or unstaged edits. For clean tracked files, verify that the current version
is recoverable from Git. For modified tracked or untracked files, use an available
appropriate recovery mechanism, such as trash, editor history, or a protected
local copy, and verify that it preserves the exact current version. The mere
presence of Git, history, or a backup is not verification.

Do not prescribe a backup system or expose sensitive content while preserving
it. Read bytes only as needed to preserve or verify recovery, without printing
them. If safe recovery cannot be established, leave the file intact and ask for
explicit consent to lose its current contents; a generic deletion request is not
that consent. When recovery is verified, carry out the authorized deletion without
an extra confirmation and report how to recover the file.

When the host permits a choice, prefer a narrow non-content-returning deletion
operation over a patch that echoes removed contents. Verify deletion through
repository status or a path search. Never choose irreversible deletion merely
to reduce transcript noise.

If the host requires a content-returning edit primitive, use it once, do not
repeat its payload, and report only the deleted paths and reason.

When reporting changes:

- summarize behavioral impact;
- list changed files only when useful;
- mention exact functions or paths when needed;
- quote only small snippets that are necessary as evidence;
- provide a patch or diff only when the user explicitly asks for raw diff, patch, or exact code changes.

Bad:

```diff
- old code
+ new code
```

Good:

```text
Changed `DownloadManager.try_acquire()` to release the global slot if the per-user slot is rejected.
Validation: `uv run pytest` passed.
```

## Risk Control

Prefer local, reversible changes.

Before editing shared contracts, public APIs, migrations, deployment configuration, CI pipelines, dependency versions, or generated files, verify that the change is required for the requested task.

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

- `references/communication-rules.md`: load when drafting external-facing technical text, PR descriptions, release notes, or engineering tickets; includes local style calibration and concise artifact rules. Also use for non-trivial output conflicts.
- `references/language-rules.md` and `references/selected-context-rules.md`: use for non-trivial language, selected-context, or scope conflicts; core principles are summarized above.
- `references/implementation-workflow.md`, `references/code-change-rules.md`, and `references/validation-rules.md`: load for medium- or high-risk implementation, shared contracts, public APIs, migrations, deployment configuration, CI pipelines, dependency versions, generated files, or when this core is insufficient to choose the safe change or validation path.
- `references/code-change-rules.md`: also load when choosing between a local refactor and a bounded rebuild from requirements/facts; neither authorizes an undecided architecture or product change.
- `references/testing-rules.md`: load for test or regression work.
- `references/python-testing-rules.md`: load with `references/testing-rules.md` for Python test or regression work.

Supporting templates:

- `templates/change-plan.md`
- `templates/pr-summary.md`

Examples:

- `examples/implementation.md`
- `examples/bug-fix.md`
- `examples/tests.md`
- `examples/ci-fix.md`
