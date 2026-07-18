# Behavior Evaluation

Maintainer guide for checking whether skill changes improve observable agent
behavior across supported runtimes. This is a manual evaluation contract, not
an execution harness or a run log.

## Method

For each scenario:

1. Start a fresh agent context with the relevant installed skill.
2. Use the prompt without adding the expected answer or evaluation rubric.
3. Record pass or fail against every required and forbidden behavior.
4. Run each scenario once on Codex and Claude.
5. Repeat a failed scenario once with the same prompt.

A repeated failure is stable and blocks completion. Differences in wording or
formatting are acceptable when the behavioral contract is preserved.

Do not store run transcripts or model-specific results in this file. Report
them in the PR, release notes, or delivery summary for the change.

## Critical failures

The following failures always block completion when repeated:

- editing outside the explicitly approved scope;
- expanding selected context without evidence that it is insufficient;
- returning a review without a verdict;
- mixing a confirmed defect with an optional improvement;
- proposing a mock-driven test that does not verify observable behavior.

## Scenarios

### ED-REVIEW-01: Review with no confirmed findings

- Mode: `engineering-delivery` review.
- Prompt: `Review this PR. The selected diff contains no confirmed defects. Tests were not run.`
- Required: begin with `Pass` or `Blocked by missing evidence`; state the
  validation gap without inventing a defect.
- Forbidden: empty findings sections, speculative findings, or a long summary
  before the verdict.
- Output: verdict, then only the validation gap and material residual risk.

### ED-REVIEW-02: Blocking defect and optional idea

- Mode: `engineering-delivery` review.
- Prompt: `Review this PR. The diff contains a confirmed null dereference. A helper could also be renamed, but the rename is not required.`
- Required: use `Changes required`; put the null dereference in blocking
  findings and the rename in optional improvements.
- Forbidden: assigning both items the same severity or presenting the rename
  as required for merge.
- Output: verdict followed by non-empty, relevant sections only.

### ED-REVIEW-03: External recommendations

- Mode: `engineering-delivery` review with recommendation-audit behavior.
- Prompt: `Audit these review comments: A says validation is absent; B requires extracting a microservice; C asks for a timeout that the diff already adds. Verify each premise.`
- Required: classify every recommendation as `Correct`, `Correct but optional`,
  `Incorrect`, `Already addressed`, or `Invalid premise`; name missing evidence.
- Forbidden: accepting the recommendations as a batch or turning the audit
  into an architecture implementation plan.
- Output: one classification and concise rationale per recommendation.

### ED-SCOPE-01: Adjacent improvement under delivery pressure

- Mode: `engineering-delivery` implementation.
- Prompt: `Fix the selected parsing bug before today's release. A nearby public API rename would be cleaner but is not required. Make the change now.`
- Required: limit the change to the bug and its necessary validation; leave the
  rename as an optional finding or follow-up.
- Forbidden: performing the rename because it is nearby, easy, or cleaner.
- Output: scoped change and validation result; optional follow-up only if useful.

### ED-EXPLORE-01: Sufficient traceback

- Mode: `engineering-delivery` diagnosis.
- Prompt: `The traceback identifies a KeyError in the first application frame and shows the invalid input. Diagnose it; do not edit files.`
- Required: diagnose from the traceback and stop when the conclusion is
  supported.
- Forbidden: repository-wide exploration, speculative adjacent findings, or
  edits.
- Output: cause, evidence, remaining uncertainty, and next safe action.

### ED-EXPLORE-02: Selected context is sufficient

- Mode: `engineering-delivery` review.
- Prompt: review only this selected context and decide whether empty input is
  handled:

  ```python
  def parse(value: str) -> str:
      if not value:
          raise ValueError("value is required")
      return value.strip()

  def test_empty_value_is_rejected():
      with pytest.raises(ValueError, match="value is required"):
          parse("")
  ```
- Required: keep review inside selected context and direct evidence.
- Forbidden: broad repository audit or unrelated refactoring suggestions.
- Output: verdict and supported findings or validation gaps only.

### EA-DISPOSITION-01: Migration lacks rollback

- Mode: `engineering-architecture` migration or readiness review.
- Prompt: `Review this migration. It cannot currently roll back or safely mitigate partial failure.`
- Required: begin with a negative or conditional verdict; classify rollback as
  `Required before implementation`; state validation and mitigation needs.
- Forbidden: proceeding with implementation sequencing as if rollback were
  optional.
- Output: verdict, disposition, evidence, minimum next step, validation, and risk.

### EA-DISPOSITION-02: Broker lacks evidence

- Mode: `engineering-architecture` decision support.
- Prompt: `Should this service add a broker? No load metrics, incidents, ownership split, or current bottleneck are available.`
- Required: classify the broker as `Defer pending evidence` or `Do not
  implement`; name the evidence that could change the decision.
- Forbidden: inventing scale, ownership, incidents, or a target architecture.
- Output: verdict, disposition, current/minimal/proposed comparison, and
  confidence.

### PY-TEST-01: Pure function

- Mode: `engineering-delivery` test work with Python rules.
- Prompt: `Propose tests for a pure Python slug-normalization function.`
- Required: choose focused unit tests with real inputs and returned-value
  assertions.
- Forbidden: component setup, mocks, or assertions on private helpers.
- Output: target regression, test level, cases, and observable assertions.

### PY-TEST-02: Service with SQLite and filesystem

- Mode: `engineering-delivery` test work with Python rules.
- Prompt: `Test a Python service that persists through a fast SQLite repository and writes a file under a temporary directory.`
- Required: prefer the real service, temporary SQLite database, real
  transaction, and `tmp_path`; assert persisted state and file contents.
- Forbidden: replacing the repository or storage with mocks only to simplify
  setup, or asserting only call counts.
- Output: target regression, component-level boundary, fixtures, and observable
  assertions.

### PY-TEST-03: Nondeterministic HTTP boundary

- Mode: `engineering-delivery` test work with Python rules.
- Prompt: `Test a Python adapter for an external nondeterministic HTTP API without making live network calls.`
- Required: use a controlled fake server or transport stub; verify protocol
  mapping and externally visible error behavior.
- Forbidden: live network as the regression test or deep mocking of internal
  client helpers.
- Output: boundary, test double choice, responses, and observable assertions.

### PY-TEST-04: Hard-wired legacy collaborator

- Mode: `engineering-delivery` test work with Python rules.
- Prompt: `A legacy Python service has a hard-wired internal collaborator. Adding a seam would require disproportionate unrelated refactoring. Propose a regression test.`
- Required: allow a narrow, explained `monkeypatch` legacy exception; keep the
  real service and assert public behavior or observable side effects.
- Forbidden: a deep mock graph, assertions limited to internal calls, or
  presenting the exception as the preferred default.
- Output: reason for the exception, narrow patch point, observable assertions,
  and residual coupling.

## Repository checks

Behavior evaluation complements, but does not replace, repository validation:

```bash
python3 .github/scripts/check_skills.py
git diff --check
```
