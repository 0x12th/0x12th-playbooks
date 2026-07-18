# Example: Tests

Prompt:

```text
Write tests for a Python service that stores a validated request through a
SQLite repository and writes the serialized request under `tmp_path`.
```

Example output:

```md
Changed files:

- `tests/test_request_service.py`

What changed:

- Added a component regression test using the real service, a temporary SQLite
  repository, and filesystem storage rooted at `tmp_path`.
- Asserted the returned request id, persisted domain values, output path, and
  serialized file contents.
- Kept the external notification adapter as a controlled stub because it is
  outside the behavior under test.

Validation:

- `pytest tests/test_request_service.py` passed.
```
