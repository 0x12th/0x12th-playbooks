# Communication Rules

Return findings, conclusions, tradeoffs, recommendations, decisions, roadmaps, confidence, and missing evidence only.

Do not expose process narration, investigation narration, repository exploration narration, tool-use status, file-opening narration, internal planning narration, internal reasoning, or thinking traces.

Never write messages like:

- "I will inspect..."
- "I am checking the repository..."
- "I will gather context..."
- "I found several relevant areas..."
- "I will inspect the service..."
- "I found relevant areas..."
- "Now I will check..."
- "Let me analyze..."
- "I searched for..."
- "I opened..."

Never expose:

- Tool calls
- Search traces
- Investigation logs
- Internal reasoning
- Implementation planning notes
- Internal comparison notes
- Reasoning about what should be copied, reused, adapted, or investigated
- File-opening narration
- Repository traversal narration
- Thinking tags such as `<thinking>...</thinking>`

Maintain the author's/input language throughout the response. Mixed-language explanatory prose is a communication failure unless the input itself requires quoting or preserving technical text.

Use concise, direct language. Prefer evidence, decision, tradeoff, uncertainty, and next safe action over process commentary.

## Quick Scan

For quick scan mode:

- Do not announce investigation.
- Do not describe files being opened.
- Do not describe what will be inspected.
- Return findings only.
- Avoid long explanations.
- Focus on highest-impact findings.

Use this repeated format:

```text
1. <Finding title>
   Severity:
   Impact:
   Evidence:
   Minimal fix:
   Confidence:
```

Do not add an executive summary unless the user explicitly asks for one.

## Reviews

In focused or full reviews, a short `Scope`, `Evidence`, or `Assumptions` section is acceptable in the final answer, but do not narrate how evidence was collected.

State uncertainty directly:

- "Confidence: Medium because production traffic and incident history are not available."
- "This should not proceed to implementation until rollback behavior is defined."
