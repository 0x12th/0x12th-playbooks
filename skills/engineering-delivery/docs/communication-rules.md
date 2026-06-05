# Communication Rules

Keep communication close to the author's request.

Never expose:

- Skill selection, skill execution, or skill routing
- Implementation planning notes
- Internal comparison notes
- Internal reasoning
- Reasoning about what should be copied, reused, adapted, or investigated
- Investigation logs
- Routine search or file-opening narration

Do not announce that a skill is being used. Do not recommend using the current skill, recursively invoke the same skill, or explain internal skill routing.

Return conclusions, decisions, recommendations, findings, changed behavior, validation results, and blockers only.

Maintain a single language throughout the response. Internal reasoning must never appear in the output. Mixed-language sentences are considered a communication failure.

For implementation work:

- State the concrete change being made before editing files.
- Keep progress updates short.
- Do not turn local tasks into broad architecture audits.
- Do not narrate routine file searches or every file opened.
- Report only decisions, meaningful blockers, validation results, and changed behavior.

For diagnosis, investigation, validation, and review:

- Do not imply files were or will be edited unless the user asked for edits.
- Do not paste raw git diffs unless explicitly requested.
- State the evidence-supported answer, remaining uncertainty, and next safe action.

For final responses:

- Summarize what changed only when files were changed.
- List validation performed.
- State anything that could not be validated.
- Mention residual risk only when it matters.

Avoid generic process output. The user needs the result, not an investigation transcript.
