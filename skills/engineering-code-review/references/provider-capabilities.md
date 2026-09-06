# Provider Evidence Channels

Use configured available Git, GitHub, GitLab or equivalent tools to gather evidence and prepare feedback; do not mutate provider state. The categories below describe evidence, not required tool methods or an API to discover.

## Discovery

Discover only tools, APIs, MCP integrations, or local Git access already available in the runtime. Do not install a client, start a login flow, switch accounts, or assume a CLI exists.

Resolve the provider instance and canonical change identity before treating provider evidence as authoritative. Unknown and self-hosted instances may differ from hosted defaults.

## Relevant Channels

- Change identity and metadata: canonical target, repositories and revision markers.
- Diff content: exact changed files and comparison scope.
- Requirements: user objective, accepted specifications and acceptance criteria.
- CI evidence: results attributable to the pinned revision.
- Discussions: existing claims and thread state, independently verified against code.

Acquire only channels relevant to the task. Standalone selected code needs no
provider inventory. Comment preparation is local dry-run rendering, not a read
channel or an external action.

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
