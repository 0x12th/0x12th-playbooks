# Communication Rules

For all review modes, return findings, decisions, or next steps after enough evidence is collected.

Do not expose investigation process.

Never write messages like:

- "I will inspect..."
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
- File-opening narration
- Repository traversal narration

Use concise, direct language. Prefer evidence, decision, tradeoff, uncertainty, and next action over process commentary.

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
```

Do not add an executive summary unless the user explicitly asks for one.

## Reviews

In focused or full reviews, a short "Scope" or "Evidence" section is acceptable in the final answer, but do not narrate how evidence was collected.

State uncertainty directly:

- "Confidence: Medium because production traffic and incident history are not available."
- "This should not proceed to implementation until rollback behavior is defined."
