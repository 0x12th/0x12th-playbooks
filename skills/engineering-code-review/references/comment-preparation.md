# Preparing Review Feedback

Comment preparation is a read-only rendering step after findings, verdict, and coverage are stable.

## Prepare Comments

For each candidate comment:

1. Confirm that the underlying finding is suitable for a concise review comment.
2. Deduplicate by root cause and independently verified existing discussion.
3. Select the narrowest current location supported by the pinned snapshot.
4. Render the body using explicit user style, accepted repository conventions, or the `concise-peer` baseline.
5. Mark it `inline candidate` when the finding has a current source path and line; otherwise mark it `general candidate`. Do not construct provider-native positions.
6. Preserve any privacy or security restriction.
7. Return the prepared payload and state that no external action was performed.

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

Posting comments, submitting reviews, approving, requesting changes, resolving threads, and merging are outside this skill.

A provider-specific adapter must own authentication, current diff versions, native positions, retries, idempotency, partial outcomes, and reconciliation. This skill prepares feedback but never claims that an external action occurred.
