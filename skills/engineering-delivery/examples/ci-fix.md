# Example: CI Fix

Prompt:

```text
Fix the failing CI test and run the relevant validation.
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
