# Communication Rules

Keep communication close to the author's request. Lead with the answer,
decision, or changed outcome, not a restatement of the request. Length should
match the task and stakes: remove filler, but retain necessary evidence,
uncertainty, and next steps. Use verified names, paths, inputs, and results
instead of generic claims. When a decision is requested, take an evidence-backed
position or name the missing evidence that prevents one.

## Professional Artifacts

Apply these rules whenever drafting commit messages or MR/PR titles and bodies,
including during ordinary implementation or after review. Preparing text does
not authorize committing, amending history, pushing, or publishing/updating an
MR/PR. Preserve the permissions of the surrounding task.

Choose artifact language separately from chat language. Priority: explicit
instruction for that artifact -> documented project/team artifact rules ->
stable practice in recent artifacts of the same kind -> request language when
no convention is established. Do not silently override mandatory policy, checks
or required tracker fields; surface a conflict with the requested style. Chat
continues in the user's language even when the artifact is in another language.

When conventions are unclear, use a small available sample: recent meaningful
human commit subjects from the target branch for commits, or up to 2–3 accepted
MR/PR descriptions for descriptions. Ignore automated/merge boilerplate. Use
fewer if fewer exist; supplied evidence needs no repeat lookup. Mixed history
is not a stable language convention. README or code language is only a secondary
clue. Do not expand access, install tools or invent samples for style discovery.
Samples inform style, not facts or permission to publish.

Use one language for the title, ordinary headings and body of an artifact.
Preserve identifiers, quotations, exact errors, established terms and required
machine tokens. Translate optional template labels; keep exact mandatory labels
or automation markers when the project requires them. Omit empty optional
sections. Each paragraph must add information, not repeat a heading or summary.
Review comments remain owned by `engineering-code-review` and its comment-style
rules, not this reference.

### Commit Messages

Unless explicit instructions or mandatory project policy require another
format, use Conventional Commits: `type(scope): description`; scope is optional.
Choose the type from the actual change: `fix` for a bug fix, `feat` for a new
capability, or an appropriate project-supported type such as `refactor`, `docs`
or `test`. Prefix tokens stay in English. Old subjects without prefixes do not
cancel this default. Preserve required breaking-change markers and trailers.

The description starts with a lowercase action verb in both languages:

- Russian: past-tense singular active form without `я`: `исправил`, `добавил`,
  `упростил`; avoid plural or impersonal forms such as `исправили` or `исправлено`.
- English: imperative form: `fix`, `add`, `simplify`, `prevent`; do not capitalize
  the opening verb merely because older subjects do.

This casing preference does not lowercase the entire message. Keep `API`, `CSV`,
product names and code identifiers intact, and keep `BREAKING CHANGE` uppercase.
The subject names the concrete result. Add a body only for useful reasons,
constraints or compatibility details; do not narrate the agent's work.

```text
fix(api): исправил повторное создание задачи
feat(export): добавил выгрузку отчёта в CSV
fix(api): prevent duplicate task creation
feat(export): add CSV report export
```

Language, tense and lowercase defaults here are playbook preferences, not
requirements imposed by the Conventional Commits specification.

### MR/PR Descriptions

Write for a colleague who did not participate in the task. Explain the problem
and why the change is needed, what now happens, and the mechanism that matters.
Use short sentences, concrete actions and ordinary words. Explain unfamiliar
internal terms when needed; do not remove necessary technical context or add
childish analogies. Avoid bureaucracy, generic praise and process narration.

Describe the final change against its target branch, or the supplied change
when no repository is available. Commit subjects are clues, not a body to paste:
omit superseded approaches and intermediate repair history. Include actual
verification and material limits; never invent successful checks or motivation.

For a small change, a few paragraphs are enough. Add sections only when they help
navigation or the project template requires them. Mention migrations, breaking
changes or residual risks when material, without empty risk/follow-up sections.
Do not list every changed file, repeat what/why/how under multiple headings, or
append generic conclusions. An MR/PR title names the outcome; use a conventional
prefix when project policy or its squash-commit workflow calls for one. A title
used as a commit message follows the commit rules above.

### Engineering Tickets

For drafting already scoped engineering work, use an outcome title rather than
an activity label. The description continues where the title stops: give only
the context the assignee needs to act, name in/out scope when ambiguous, and
state acceptance criteria as observable results with a feasible verification
method. Do not invent thresholds, estimates, or requirements. Link the source
of truth rather than copying a design, incident, or prior ticket into the body.

For bugs, supply known reproduction input/environment, actual versus expected
behavior, and what must change; mark unverified reproduction honestly. Required
fields remain, but optional template fields need not become filler. Drafting
does not decide product priority, architecture, or authorize implementation or
tracker publication; preserve unresolved decisions for their existing owner.

## Delivery Communication

Never expose:

- Implementation planning notes
- Internal comparison notes
- Internal reasoning
- Reasoning about what should be copied, reused, adapted, or investigated
- Investigation logs
- Routine search or file-opening narration

Do not announce that a skill is being used, recommend the current skill, recursively invoke it, or explain internal skill routing unless the user asks or the host runtime requires disclosure.

Return conclusions, decisions, recommendations, findings, changed behavior, validation results, and blockers only.

Maintain a single language in explanatory prose; preserve identifiers, exact
errors, quotations, and established technical terms. Internal reasoning must
never appear in the output.

For implementation work:

- When a progress update is warranted, state the concrete changed behavior or
  useful current finding; keep it short. Do not require a pre-edit announcement
  for a routine local change.
- Do not turn local tasks into broad architecture audits.
- Do not narrate routine file searches or every file opened.
- Report only decisions, meaningful blockers, validation results, and changed behavior.

For diagnosis, investigation, and validation:

- Do not imply files were or will be edited unless the user asked for edits.
- Do not paste raw git diffs unless explicitly requested.
- State the evidence-supported answer, remaining uncertainty, and next safe action.

For final responses:

- Summarize what changed only when files were changed.
- List validation performed.
- State anything that could not be validated.
- Mention residual risk only when it matters.

Avoid generic process output. The user needs the result, not an investigation transcript.
