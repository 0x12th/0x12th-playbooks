# Provider Capability Contract

Provider support is capability-based. This skill uses read capabilities and prepares feedback; it does not mutate provider state.

## Discovery

Discover only tools, APIs, MCP integrations, or local Git access already available in the runtime. Do not install a client, start a login flow, switch accounts, or assume a CLI exists.

Resolve the provider instance and canonical change identity before treating provider evidence as authoritative. Unknown and self-hosted instances may differ from hosted defaults.

## Capabilities

- `metadata.read`
- `diff.read`
- `requirements.read`
- `ci.read`
- `discussions.read`
- `comments.prepare`

Authentication alone does not prove that a channel is complete or current.

## Read Result Contract

Every evidence channel records:

```text
status: complete | partial | unknown
reason
observed count
expected count when available
pagination markers
version markers
applied limits
source provenance
```

Use `complete` only when all advertised pages or items were acquired and no provider or adapter truncation marker applies. Use `partial` for a known subset and `unknown` when completeness cannot be established.

Never translate permission filtering, interrupted pagination, rate limiting, timeout, shallow history, omitted patch content, generated-file filtering, adapter error, or budget exhaustion into an empty complete result.

## Portable Fallback

- With provider reads: review the pinned provider change and record each channel's completeness.
- With local Git only: review immutable local objects when target identity and comparison semantics can be resolved.
- With no provider/network capability: review supplied code, a patch, or an explicit local snapshot.
- With no delegation: use the same finding and verdict model in one agent.
- With incomplete provider context: continue only within the evidence-supported scope and report the limitation.

Finding, verdict, attribution, and coverage semantics must not depend on provider choice.

## External Actions

Posting comments, approving, requesting changes, resolving threads, and merging are outside this skill. If requested, return prepared comments and state that a provider-specific adapter is required.
