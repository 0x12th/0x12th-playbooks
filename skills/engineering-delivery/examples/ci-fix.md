# Example: CI Fix

Prompt:

```text
Use engineering-delivery.

Why is CI failing, and fix it if the failure is in this repository.
```

Example output:

```md
Changed files:

- `pyproject.toml`
- `tests/test_config_loading.py`

What changed:

- Fixed the test fixture path used by CI's working directory.
- Added a regression test for config loading from the project root.

Validation:

- `pytest tests/test_config_loading.py` passed.
- `ruff check .` passed.

Residual risk:

- Full CI was not run locally because the deployment job requires CI secrets.
```
