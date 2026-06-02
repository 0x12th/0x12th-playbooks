# Example: Bug Fix

Prompt:

```text
Use engineering-delivery.

Fix the bug where retryable external dependency errors are treated as permanent failures.
```

Example output:

```md
Changed files:

- `src/integrations/errors.py`
- `src/jobs/retry_policy.py`
- `tests/test_retry_policy.py`

What changed:

- Classified external timeout and rate-limit errors as retryable.
- Kept validation and malformed payload errors as permanent failures.
- Added regression coverage for retryable and permanent dependency errors.

Validation:

- `pytest tests/test_retry_policy.py` passed.
```
