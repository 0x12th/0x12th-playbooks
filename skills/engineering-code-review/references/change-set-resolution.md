# Change-Set Resolution

Use this reference for non-trivial target resolution, snapshot control, incremental review, discussions, or large changes. Standalone selected code uses exact supplied text as its scope/snapshot and needs no Git OIDs, provider inventory or change-set ledger; use the short Selected Code path in SKILL.md.

## Resolve One Target

MR/PR:

- Resolve the provider instance, canonical target project, change number, source and target repository identities, target branch, full base and head OIDs, start or merge-base OID, and provider-native diff version.
- Forks require separate source and target repository identities.
- Pin relevant CI and discussion version markers where available.

Current branch:

- Resolve the intended base branch from explicit user input, repository convention, tracking metadata, or provider metadata.
- Ask only when plausible bases produce materially different change sets.
- Resolve the merge-base and head to full immutable OIDs once.

Commit:

- Review only the named commit relative to its parent.
- A merge commit may need explicit parent semantics when the review objective is ambiguous.

Commit range:

- Use only the explicitly named immutable range.
- Do not silently replace two-dot, three-dot, or provider comparison semantics with another interpretation.

Working tree:

- Include staged, unstaged, and untracked content only when explicitly requested.
- Record which categories and paths were selected.
- Snapshot content before analysis so later edits cannot silently change the target.

Selected code or file:

- Treat selection as the initial boundary.
- Expand only when a direct dependency is necessary to establish behavior or impact.

## Snapshot Vector

Record available values:

```text
provider instance
canonical project/change ID
source repository ID
target repository ID
full base OID
full head OID
start or merge-base OID
provider-native diff version
CI version or run markers
discussion version markers
```

Resolve symbolic refs once. Use immutable OIDs for all later evidence. If provider channels disagree, stop and report the inconsistency.

A snapshot is stale when the head, base, target branch, provider diff version, or other material version marker changes. Do not carry a verdict or prepared comment across staleness without re-review.

## Local-State Preservation

Never switch, reset, stash, clean, or otherwise rewrite the user's current worktree for review.

Use the current checkout only when its `HEAD` matches the pinned head and local dirty state is excluded from the target. Otherwise prefer provider evidence and existing Git objects.

A remote fetch is acceptable only when bounded, non-destructive, visible as a metadata mutation, and performed through already configured access. Do not force-update user refs.

An isolated worktree requires explicit permission and is not a sandbox. If isolation or safe execution is unavailable, preserve the worktree and report the validation gap.

## Bounded Impact Cone

Expand in order and stop as soon as the risk is supported:

1. Changed lines.
2. Containing function, class, or configuration block.
3. Direct callers, callees, and affected types.
4. Related tests.
5. Affected API, schema, migration, feature flag, or runtime configuration.
6. History or blame only when intent or regression cannot otherwise be established.

Do not expand into a repository-wide audit. Do not report unrelated pre-existing defects.

## Existing Discussions

Analyze the pinned code independently before reading existing conclusions. Then classify related discussions as:

- new;
- already raised and still relevant;
- resolved in the current revision;
- outdated;
- externally suggested but not independently confirmed.

Do not duplicate a verified open thread. Do not trust a resolved or outdated state without checking the current revision. Incomplete discussion pagination limits deduplication and must be visible in coverage.

## Incremental Re-review

Require:

- previous reviewed base/head or equivalent immutable snapshot;
- previous finding state;
- previous coverage state;
- current immutable snapshot;
- enough lineage to compare revisions.

Then:

1. Compare previous and current heads.
2. Recheck each old finding against current code.
3. Inspect the bounded impact cone of every attempted fix.
4. Inspect newly changed areas for regressions.
5. Report `Resolved`, `Still open`, `New findings`, and `Unable to verify`.

Fall back to a full review after force-push or rebase, base change, missing lineage, incomplete prior coverage, changed review policy, or changed provider semantics.

## Large Changes

Inventory files, languages, and change types first. Prioritize:

1. public contracts;
2. authentication and security boundaries;
3. data, schema, and migrations;
4. concurrency and failure paths;
5. dependencies, configuration, and CI;
6. generated or derived output only where necessary.

Split work by coherent subsystem, not arbitrary line count. Record each material area as `reviewed`, `limited`, `generated/derived`, `skipped`, or `blocked`. Do not issue unconditional `Pass` while material areas remain unreviewed.

Subagents are optional. When used, they remain read-only, receive the same snapshot and evidence rules, and cover independent subsystems or risk lenses. The aggregator verifies premises, resolves conflicts, deduplicates root causes, and derives one verdict. The process must also work without delegation support.
