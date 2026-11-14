# GitHub Review Evidence

These read-side semantics were checked against the official GitHub REST API documentation on 2026-08-30:

- [Pull requests](https://docs.github.com/en/rest/pulls/pulls)
- [Pull request review comments](https://docs.github.com/en/rest/pulls/comments)
- [Pull request reviews](https://docs.github.com/en/rest/pulls/reviews)
- [REST API pagination](https://docs.github.com/en/rest/using-the-rest-api/using-pagination-in-the-rest-api)

This reference covers read-side review evidence only and contains no executable provider commands.

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

Pin the full base/head repository identities and SHAs returned for the PR. If they change during review, mark the snapshot stale and stop.

Before merge, `merge_commit_sha` can refer to a provider-generated test merge commit and may change; it is not the reviewed head SHA. Mergeability can be computed asynchronously and may temporarily be unknown. Neither value is a stable replacement for the pinned base/head vector.

A submitted review records a commit ID, but existing reviews and comments can refer to earlier revisions. Preserve original and current commit/position provenance when comparing discussions.

## Diff Completeness

GitHub supports diff/patch representations and a paginated changed-files channel. Current official documentation states that the changed-files listing returns at most 3000 files. Individual patch content can be absent or insufficient for complete review.

The pull-request commit listing has its own maximum of 250 commits; use another already available read path only when its semantics and completeness are verified. Do not interpret a capped list as complete.

Follow provider pagination links until completion. Record file counts, page markers, missing patch content, caps, and adapter limits. Material unreviewed files or commits prevent unconditional `Pass`.

## CI Evidence

Acquire statuses and checks through an available read capability. Record the
repository, run/check identity, workflow event, and revision actually checked out
or tested; a reported head SHA alone does not prove which code ran.

- **Head checks:** evidence for the pinned head only when the tested revision and
  repository match it.
- **Merge-result checks:** evidence for the tested integration result when its
  immutable SHA and verified composition bind it to the pinned base/head. For a
  merge queue, include the other changes in that exact group; this does not prove
  the head passed in isolation or a different queue composition passed.
- **Unrelated, stale, or unverified checks:** not coverage of the reviewed snapshot.
  Record the affected validation gap without discarding other valid evidence.

For `pull_request`, GitHub Actions with the default checkout tests the PR merge
branch. Its SHA can legitimately differ from the head. Verify what the workflow
actually tested and keep merge-result evidence separate from head evidence; do
not replace the pinned base/head identity with a mutable merge ref. See the
[official workflow event semantics](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#pull_request).

Permission filtering, rate limits, or missing check channels produce `partial` or `unknown` coverage, not an empty complete result.

## Discussions

GitHub PR conversation evidence is split across issue-style comments, inline review comments, and pull-request reviews. Reading only one channel is not complete discussion acquisition.

Review comments carry path, diff-hunk, current/original commit, line/side or legacy position data, and reply relationships. Reviews carry state and commit identity. Acquire all relevant pages and preserve these native identities before deduplicating.

Verify old, dismissed, or outdated comments against the pinned revision. Do not infer that a lack of inline comments means there are no general review comments or reviews.

## External Actions

Review and `prepare comments` are read-only. When the user separately and explicitly requests publication, an already available GitHub write tool may publish revalidated comments against the confirmed PR and revision. Verify native diff positions, permissions, duplicate-posting risks, and partial outcomes; do not start authentication or install tools. If publication is unavailable, return prepared comments and state the limitation. Submitting reviews, approving, requesting changes, resolving threads, and merging require separate explicit authorization. Never claim an external action occurred without confirmation.
