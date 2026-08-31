# Example: GitLab Merge Request Review

Prompt:

```text
Review GitLab MR !42 and prepare comments. Do not post anything.
```

Observed example evidence:

- The GitLab instance and target project are resolved.
- The MR `iid`, source/target project IDs, target branch, full base/head/start SHAs, and latest diff-version ID agree.
- Metadata and discussions are complete.
- One material file diff is marked `too_large`; the remaining file pages are complete.
- The visible head pipeline belongs to the pinned head SHA and passed.

Example output:

```md
Verdict: Blocked by missing evidence

Scope:
- Target: canonical GitLab project and MR `!42`
- Snapshot: pinned base/head/start SHAs plus GitLab diff-version ID
- Mode: Change Request Review + prepare comments
- Limitations: one material changed file is unavailable because the provider marked its diff `too_large`

Questions / missing evidence:
- The unavailable migration file can alter stored data, so its contents and related rollback behavior are required before a safe verdict.

Validation:
- GitLab head pipeline passed for the pinned head SHA
- No local checks were run because the full material change set was unavailable

Coverage:
- Reviewed: all available source, test, and configuration diffs; complete discussion pages
- Blocked: material migration file marked `too_large`

Prepared comments:

- Placement: general
- Body: `не вижу саму миграцию: GitLab отдал этот файл как too_large. без неё нельзя проверить преобразование данных и откат`

Prepared only; external provider actions are outside this skill.
```

The example does not convert an unavailable inline position into a fake inline comment and does not treat a truncated diff as complete.
