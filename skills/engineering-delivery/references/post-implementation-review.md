# Post-Implementation Review

Use after feature or behavior-changing implementation and meaningful validation.
Delivery coordinates the cycle; `engineering-code-review` owns the read-only
assessment. An implementation request covers this assessment and confirmed
in-scope fixes. Existing authorization boundaries still govern optional changes,
new product/architecture decisions and external publication.

## Prepare the Review

1. Resolve the feature's original base and exact final state. Review the whole
   feature, including its integration, rather than only the most recent commit.
2. Explicitly select the task's committed, staged, unstaged and untracked files
   that form the delivered result. Preserve unrelated user work. Use immutable
   OIDs for commits and captured contents with a file inventory for local changes;
   do not commit, stash, reset or switch the user's checkout just to obtain a diff.
3. Give the reviewer original requirements, accepted design constraints/decisions
   and material rationale, applicable project rules, the snapshot and access to
   relevant callers, dependencies, contracts and tests. Attach actual validation
   with its scope and revision. Missing evidence stays unknown.
4. Start a fresh context using code review's `templates/independent-review.md`.
   Exclude the authoring conversation, self-assessment and other reviewers'
   conclusions. Accepted constraints remain visible; ignorance of requirements
   is not independence. Do not make concurrent edits to the reviewed snapshot.

If a file or revision moves, mark the review stale and re-pin the result before
using its findings. Do not silently mix new content into an existing review.

## Choose the Review Scope

One general reviewer checks requirements, correctness, integration and useful
simplification. A clean, supported review is a valid result; no finding quota.

Consider one additional fresh reviewer when the change introduces a new layer,
dependency, state owner, parallel execution/compatibility path or shared contract
and a named structural question needs separate judgment. State that question
and the affected scope. Do not add a reviewer just because the diff is long or
the desired tone is "harsh". Both reviewers use the same snapshot and work
without seeing each other's findings.

For change-level complexity, use code review's simplicity/integration criteria.
For a necessary design choice, use `engineering-architecture` in Design Challenge
mode for that choice only. Preserve accepted behavior; a broader redesign is a
proposal. Neither reviewer edits code, posts comments or spawns other reviewers.

If fresh context cannot be created, apply the same review rules in a separate
self-review pass. Report `independent review unavailable`, give the capability
limit and a reusable review brief for another session. Do not stop ordinary
scoped implementation solely because delegation is absent; do not declare an
explicit independent-approval requirement satisfied.

## Verify, Fix and Converge

- Reconcile one prioritized report, deduplicated by root cause. Keep blocking
  defects, optional improvements and missing evidence distinct.
- Check each finding against the snapshot before accepting it. Use Recommendation
  Audit for disputed/external feedback: Correct, Correct but optional, Incorrect,
  Already addressed or Invalid premise. Agreement between agents is not proof.
  A code trace, reachable counterexample or focused check must support a defect;
  a simplification needs a viable alternative preserving the accepted constraints.
- Apply confirmed fixes within existing authorization and validate their affected
  behavior. Do not turn optional suggestions into mandatory rewrites. Escalate a
  genuine unresolved product/design decision with the evidence needed to decide.
- For review-and-fix, an already completed review can serve as the full pass when
  its independent origin and complete coverage of the same feature snapshot are
  verified. Establish who reviewed it and that the review ran without the author's
  implementation conversation. A self-review or review of unknown origin is supporting
  evidence; it does not satisfy or consume the independent full pass. Obtain that
  pass when available; otherwise apply the explicit capability fallback above.
  Do not restart a qualifying independent cycle merely because delivery applied fixes.
- Have a reviewer independent of the implementation context perform at most one
  Incremental Re-review after the full pass. The original independent reviewer
  may return, or another can use the prior snapshot, findings and coverage.
  Check the new snapshot, fixes and their impact cones; carry forward valid
  coverage and unresolved findings. If lineage or coverage is invalid, replace
  the targeted re-review with a full review within that same remaining round.
  Completion depends on sufficient restored coverage and no unresolved blockers;
  the fallback does not reset the budget. Report any material defect found, but
  do not keep mining unchanged code for fresh cosmetic work.
- After the repeat, report unresolved blockers/questions and the next needed
  decision. Additional review requires a stated new reason or explicit request;
  never repeat until an empty report or claim readiness because the limit expired.

Report what was implemented, actual validation, review type and snapshot, fixes
or justified dismissals, and material remaining risk. A clean implementation can
be reported with an independent-review gap, but not as independently approved.

## Learn from Confirmed Misses

After a substantive human review or a request to improve the process, examine
confirmed missed findings using the original snapshot and evidence. Identify
whether the gap was missing context, an unenforced check, an unclear standard or
a missing review step. Do not treat every accepted comment as a universal rule.

Propose the smallest reusable change: a deterministic check for mechanical
violations; a short reviewer standard with an example for judgment calls; a
context pointer for undiscoverable evidence. State the episode, intended benefit,
where the change belongs and how to check both detection and false positives.
Keep proposals separate from accepted project policy. Routine completion does
not authorize editing instructions or accumulating new rules after every run.
