# Communication Rules

Keep communication close to the author's request. Lead with the answer,
decision, or changed outcome, not a restatement of the request. Length should
match the task and stakes: remove filler, but retain necessary evidence,
uncertainty, and next steps. Use verified names, paths, inputs, and results
instead of generic claims. When a decision is requested, take an evidence-backed
position or name the missing evidence that prevents one.

## Professional Artifacts

Before drafting an external-facing PR description, release note, ticket, or
technical document, use 2–3 recent artifacts of the same type from available
local or already supplied context to calibrate register, length, and format.
Use fewer if fewer exist; do not invent samples or expand access just to build
a style corpus. Samples inform style, not facts or permission to publish.

Style priority: explicit user style -> observed repository/team style for that
artifact type -> documented style conventions -> built-in fallback here.
This is a rendering preference, not permission to override mandatory project
requirements, facts, safety rules, or required tracker fields. A few samples
calibrate a venue; they do not establish a personal imitation profile.

Use conventional templates where useful, omit empty optional sections, and let
each paragraph add information. Do not repeat headings in their opening
sentences, recap the same result in multiple summaries, or append empty
conclusions and generic offers of further help. Review comments remain owned
by `engineering-code-review` and its comment-style rules, not this reference.

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
