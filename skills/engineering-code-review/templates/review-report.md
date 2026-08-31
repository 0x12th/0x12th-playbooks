# Review Report Template

Print only non-empty sections. Replace placeholders with observed evidence; never leave a placeholder that looks like a verified fact.

```md
Verdict: Pass | Changes required | Blocked by missing evidence

Scope:
- Target: <canonical target>
- Snapshot: <full immutable base/head/version vector or selected snapshot>
- Mode/focus: <mode and modifier>
- Limitations: <material limits only>

Blocking findings:

1. <short title>
   - Severity / disposition / confidence: <...>
   - Location: <current pinned location>
   - Evidence: <immutable provenance and validation label>
   - Problem: <root cause>
   - Trigger: <reachable scenario>
   - Impact: <observable consequence>
   - Fix direction: <minimal direction, not a patch>
   - Attribution / discussion: <change relationship and dedup state>

Non-blocking findings:

1. <same compact fields as needed>

Questions / missing evidence:

- <question or material unavailable channel>

Validation:

- Provider CI: <snapshot-bound result or not available>
- Local: <exact checks actually run and result>
- Not run: <check and reason>

Coverage:

- Reviewed: <areas>
- Limited: <areas and reason>
- Generated/derived: <areas>
- Skipped: <areas and reason>
- Blocked: <areas and reason>
```

For a clean review, state immediately after the verdict that no confirmed blockers were found, then show only material validation and coverage limits.

For Incremental Re-review, replace ordinary grouping when useful with:

```text
Resolved
Still open
New findings
Unable to verify
```
