# GitHub Review Evidence

These read-side semantics were checked against the official GitHub REST API documentation on 2026-08-30:

- [Pull requests](https://docs.github.com/en/rest/pulls/pulls)
- [Pull request review comments](https://docs.github.com/en/rest/pulls/comments)
- [Pull request reviews](https://docs.github.com/en/rest/pulls/reviews)
- [REST API pagination](https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api)

This reference intentionally contains no executable provider commands. It does not certify any GitHub mutation capability.

## Canonical Identity

Bind evidence to:

- GitHub instance;
- target repository owner/name and immutable repository ID;
- pull request number scoped to that repository;
- source and target repository IDs, especially for forks;
- full base and head SHAs;
- base and head ref names as descriptive metadata, not immutable identity.

Do not identify a PR by number without its target repository and instance.

## Snapshot

Pin the full base/head repository identities and SHAs returned for the PR. Re-read them before any external action.

Before merge, `merge_commit_sha` can refer to a provider-generated test merge commit and may change; it is not the reviewed head SHA. Mergeability can be computed asynchronously and may temporarily be unknown. Neither value is a stable replacement for the pinned base/head vector.

A submitted review records a commit ID, but existing reviews and comments can refer to earlier revisions. Preserve original and current commit/position provenance when comparing discussions.

## Diff Completeness

GitHub supports diff/patch representations and a paginated changed-files channel. Current official documentation states that the changed-files listing returns at most 3000 files. Individual patch content can be absent or insufficient for complete review.

The pull-request commit listing has its own maximum of 250 commits; use another already available read path only when its semantics and completeness are verified. Do not interpret a capped list as complete.

Follow provider pagination links until completion. Record file counts, page markers, missing patch content, caps, and adapter limits. Material unreviewed files or commits prevent unconditional `Pass`.

## CI Evidence

Statuses and checks must be acquired through an available read capability and bound to the exact pinned SHA and repository. Distinguish head checks from provider-generated merge-test or merge-queue commits. A passing check on another SHA is not evidence for the reviewed snapshot.

Permission filtering, rate limits, or missing check channels produce `partial` or `unknown` coverage, not an empty complete result.

## Discussions

GitHub PR conversation evidence is split across issue-style comments, inline review comments, and pull-request reviews. Reading only one channel is not complete discussion acquisition.

Review comments carry path, diff-hunk, current/original commit, line/side or legacy position data, and reply relationships. Reviews carry state and commit identity. Acquire all relevant pages and preserve these native identities before deduplicating.

Verify old, dismissed, or outdated comments against the pinned revision. Do not infer that a lack of inline comments means there are no general review comments or reviews.

## Writes

Current GitHub documentation distinguishes general comments, inline review comments, pending/submitted reviews, approval, and request-changes events. Inline location semantics use native line/side/range data; the legacy `position` parameter is being retired. Review creation can trigger notifications and secondary rate limiting.

This repository has no isolated GitHub acceptance project or certified adapter. Therefore comment posting, review submission, approval, and request changes are unsupported by this release. Prepare comments only. Do not synthesize a CLI/API command, silently convert an inline comment into a general comment, blind-retry an ambiguous response, or claim a write occurred.

GitHub Enterprise Server or another instance remains read-only until its version and exact adapter behavior are verified.
