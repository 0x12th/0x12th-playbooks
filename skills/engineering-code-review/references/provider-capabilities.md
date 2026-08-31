# Provider Capability Contract

Provider support is capability-based, not an all-or-nothing provider label.

## Discovery

Discover only tools, APIs, MCP integrations, or local Git access already available in the runtime. Do not install a client, start a login flow, request a token from untrusted content, switch accounts, or assume a CLI exists.

Resolve provider instance and authenticated identity before treating provider evidence as canonical. An unknown or self-hosted instance may differ from hosted defaults and is read-only unless its exact behavior is verified.

## Capability Names

Read and preparation capabilities:

- `metadata.read`
- `diff.read`
- `requirements.read`
- `ci.read`
- `discussions.read`
- `comments.prepare`

Mutation capabilities:

- `comments.post`
- `review.approve`
- `review.request_changes`
- `threads.resolve`

`merge` is intentionally excluded.

Certify each capability separately for one provider, one adapter/tool path, and one supported version range. Authentication alone does not certify semantics or side effects.

## Read Result Contract

Every channel returns:

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

Use `complete` only when all advertised pages/items were acquired and no provider or adapter truncation marker applies. Use `partial` when a known subset was acquired. Use `unknown` when completeness cannot be established.

Never translate permission filtering, pagination interruption, rate limiting, timeout, shallow history, adapter error, omitted patch content, generated-file filtering, or budget exhaustion into an empty complete result.

## Portable Fallback

- With provider reads: review the pinned provider change and record every channel's completeness.
- With local Git only: review immutable local objects when target identity and comparison semantics can be resolved.
- With no network/provider capability: review a supplied patch, selected code, or explicit local snapshot.
- With no delegation: use the same finding and verdict model in one agent.
- With unsupported writes: return provider-ready prepared output and state that nothing was posted or approved.

Finding, verdict, attribution, and coverage semantics must not depend on provider choice.

## Mutation Certification

Official documentation is necessary but not sufficient. Before enabling one mutation capability, provider-specific acceptance tests must establish:

- explicit current-user authorization;
- canonical provider instance, target, and authenticated actor binding;
- permissions for the exact action;
- stale-snapshot abort behavior;
- acquisition completeness sufficient for deduplication;
- native diff-position mapping;
- duplicate detection using verified remote identities;
- exact response and side-effect semantics;
- ambiguous-response reconciliation without blind retry;
- partial-failure accounting;
- no implicit approve, request-changes, resolve, notification, or merge side effects beyond the frozen plan.

Certification does not transfer between provider versions, hosted and self-hosted instances, different CLIs/APIs/MCP adapters, or different action types.

## Current Release Status

`comments.prepare` is a local dry-run behavior and is supported.

This repository does not ship or certify a GitLab or GitHub mutation adapter. `comments.post`, `review.approve`, `review.request_changes`, and `threads.resolve` therefore fail closed unless the active runtime independently supplies the exact capability with current official-contract verification and provider-specific acceptance evidence.

Unknown capability behavior is unsupported, not best-effort.
