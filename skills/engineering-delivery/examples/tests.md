# Example: Tests

Prompt:

```text
Write tests for the request validation behavior in the selected file.
```

Example output:

```md
Changed files:

- `tests/test_request_validation.py`

What changed:

- Added coverage for missing required fields, invalid enum values, and valid payload passthrough.
- Kept tests focused on the selected validation path.

Validation:

- `pytest tests/test_request_validation.py` passed.
```
