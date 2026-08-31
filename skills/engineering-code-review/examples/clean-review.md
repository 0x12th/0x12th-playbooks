# Example: Clean Review

Prompt:

```text
Review this small patch. The exact base and head commits are provided, all changed files are present, and the targeted tests passed on the head commit.
```

Example output:

```md
Verdict: Pass

No confirmed blockers were found in the reviewed scope.

Scope:
- Target: supplied patch between the pinned full base and head OIDs
- Mode: Code Review
- Limitations: no provider discussion or broader integration-test evidence was available

Non-blocking findings:

1. Error text duplicates a nearby constant
   - Severity / disposition / confidence: low / non-blocking / high
   - Location: `src/parser.py`, changed validation branch
   - Impact: future wording changes could drift, but current behavior is correct
   - Fix direction: reuse the existing constant in a later local cleanup if desired

Validation:
- Targeted parser tests passed on the pinned head according to the supplied evidence
- No broader test suite was run during review

Coverage:
- Reviewed: all changed source and test files
- Limited: provider discussions and broader integration behavior
```

A concrete non-blocking improvement does not change `Pass`, and the validation gap does not become a fabricated defect.
