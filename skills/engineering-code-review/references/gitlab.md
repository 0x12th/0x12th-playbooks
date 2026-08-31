# GitLab Review Evidence

These read-side semantics were checked against the official GitLab REST API documentation on 2026-08-30:

- [Merge requests API](https://docs.gitlab.com/api/merge_requests/)
- [Discussions API](https://docs.gitlab.com/api/discussions/)
- [REST API pagination](https://docs.gitlab.com/api/rest/#pagination)

This reference intentionally contains no executable provider commands. It does not certify any GitLab mutation capability.

## Canonical Identity

Bind evidence to:

- GitLab instance;
- target project numeric identity and canonical path;
- merge request `iid`, which is scoped to the project;
- merge request global ID when available;
- source and target project IDs, which may differ for forks;
- source and target branch names;
- full immutable SHAs.

Do not identify an MR by `!iid` without its target project and instance.

## Snapshot

For the current MR, GitLab exposes a head SHA and latest `diff_refs` containing base, head, and start SHAs. Diff-version records expose a version ID plus `base_commit_sha`, `head_commit_sha`, and `start_commit_sha`.

Pin the provider-native diff version and full SHA vector. Confirm the selected diff version agrees with current MR metadata. Empty `diff_refs` can be temporary while a new MR is being prepared; treat that as missing evidence rather than an empty change.

`prepared_at` is populated once and does not update when later changes are added, so it is not a freshness token.

## Diff Completeness

GitLab's MR diff data is paginated and subject to provider diff limits. Current responses can mark file diffs as `collapsed` or `too_large`, and older aggregate change responses expose an `overflow` marker. Raw diffs remain subject to MR diff limits.

Record pagination and every limit marker. A page with no more returned items proves completion only when pagination metadata and provider limits are coherent. A `changes_count` value can be capped and is not sufficient proof that every file diff was acquired.

Do not issue unconditional `Pass` if a material `too_large`, omitted, overflowed, or otherwise unavailable file remains unreviewed.

## CI Evidence

GitLab MR metadata may expose a `head_pipeline`; visibility depends on permissions. Pipeline evidence is usable only after its project, SHA, ref/source, and status are bound to the pinned review snapshot.

A branch pipeline, detached MR pipeline, or merged-results pipeline can represent different code. Do not treat a passing status as coverage of the pinned head unless provenance is established. Missing pipeline visibility is `partial` or `unknown`, not proof that CI is absent.

Mergeability fields may be computed asynchronously and can be stale or transitional. They are provider state, not a substitute for review evidence.

## Discussions

MR discussions are paginated and contain nested notes. Individual notes, threads, system notes, and diff notes are distinct. Diff notes include position and version information; resolution state can change independently of code.

Acquire all relevant pages before claiming there are no existing comments or before deduplication-dependent actions. Preserve discussion and note identities, author identity, timestamps, resolution fields, and native position data.

Verify resolved and outdated discussions against the pinned code. Never infer that a missing discussion page means no comments exist.

## Writes

GitLab inline discussions depend on provider-native position data including the correct base, head, and start SHAs plus paths and line semantics. Documentation also describes permission, notification, resolution, and approval side effects, but this repository has no isolated GitLab acceptance project or certified adapter.

Therefore `comments.post`, approval, request-changes equivalents, and thread resolution are unsupported by this release. Prepare comments only. Do not synthesize a CLI/API command, silently downgrade inline feedback to a general note, or claim a write occurred.

Self-hosted GitLab instances remain read-only until their version and exact adapter behavior are verified.
