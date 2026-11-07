# Preparing Review Feedback

Comment preparation is a read-only rendering step after findings, verdict, and coverage are stable.

## Prepare Comments

For each candidate comment:

1. Confirm that the underlying finding is suitable for a concise review comment.
2. Deduplicate by root cause and independently verified existing discussion.
3. Select the narrowest current location supported by the pinned snapshot.
4. Render the body using the style priority and local sample calibration in `comment-style.md`.
5. Mark it `inline candidate` when the finding has a current source path and line; otherwise mark it `general candidate`. Do not construct provider-native positions.
6. Preserve any privacy or security restriction.
7. For a dry-run request, return the prepared payload and state that nothing was published. Any explicitly requested publication follows the separate phase below.

Use `templates/review-comment.md` when a structured preparation shape helps.

## Prepared Output

A prepared comment may include:

```text
finding ID
current path and line when available
snapshot or diff-version identity
inline candidate | general candidate
rendered comment
material evidence or privacy limitation
```

Keep structured finding metadata in the review report. The rendered comment should stay short and natural.

## External Action Boundary

`prepare comments` is always dry-run. An explicit request to publish permits a
separate phase under the [core external-action boundary](../SKILL.md#external-action-boundary).
Use an already available provider write tool after rechecking the canonical
PR/MR, current revision, findings and provider-native positions. Verify permissions,
handle retries without duplicate posting, and reconcile partial outcomes before
reporting confirmed publication.

If a suitable write tool is unavailable, return prepared comments and disclose
the limitation; do not require a new adapter, install tools or start authentication.
Submitting reviews, approving, requesting changes, resolving threads and merging
require their own explicit authorization and are not implied by comment publication.
