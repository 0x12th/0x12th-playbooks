# Example: Implementation

Prompt:

```text
Make the smallest safe change to improve observability for the schema migration path, then run relevant tests.
```

Example output:

```md
Changed files:

- `src/migrations/run_migration.py`
- `tests/test_migration_logging.py`

What changed:

- Added structured log fields for migration name, phase, duration, affected row count, and failure reason.
- Preserved existing migration behavior.
- Added a regression test verifying success and failure logs include the migration name and phase.

Validation:

- `pytest tests/test_migration_logging.py` passed.

Completion review:

- A fresh reviewer checked the complete feature snapshot, including the local
  test changes, against the logging requirements and existing migration contract.
- No confirmed blockers; the migration execution and error paths are unchanged.

Residual risk:

- This does not prove migration correctness in production.
- A post-deploy verification query or reconciliation check is still needed for the migrated table.
```
