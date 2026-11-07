# Review Contract Regressions

Maintainer-only scenarios supplementing [Behavior Evaluation](behavior-evaluation.md).
Keep this document and expected outcomes outside the reviewed workspace and the
agent's context. These are regression specifications derived from the supplied
layered-configuration diagnostic report, not bundled original fixtures, an
execution harness, new runtime skill instructions, or evidence of a quality gain.

## Evaluation Setup

Use fresh contexts and the existing read-only review and evaluation method.
Provide only the public request, code/diff, accepted contract, and factual
validation permissions. Keep diagnoses, expected findings, previous answers,
and this document private to the evaluator. Record actual checks and coverage;
an unavailable fixture/runtime is `not verified`, not a pass.

The original diagnostic fixtures and transcripts remain in the separate
experiment archive. Reuse those exact public fixtures when available. A fixture
reconstructed from the descriptions below must be labeled as a new adaptation,
checked independently, and must not be presented as the historical snapshot.
These disclosed cases are development/regression material, not an independent
holdout. Do not revise old experiment scores after adding a case.

## ECR-CONTRACT-BOUNDARY-01: Literal Replacement and Unspecified Input Grammar

**Public task:** review the complete layered-configuration change across merge
provenance, materialization, interpolation, and both current callers; use accepted
semantics rather than shell conventions; report confirmed defects with concrete
inputs, observable results, locations, and narrow remedies. No edits.

**Fixture:** the public snapshot consists of `CONTRACT.md`, `layers.py`, `merge.py`,
`interpolation.py`, `values.py`, `configuration.py`, `service.py`, `callers.py`, and
`change.diff`. The accepted interpolation clause is:

> Text values support one-pass ${NAME} and ${NAME:-fallback} interpolation using a supplied environment mapping. A defined empty environment value is still defined, so it must override fallback. An absent variable without fallback is a ConfigError. Substituted environment/fallback text is literal: do not recursively expand it.

The contract also defines declaring-layer path origin, recursive mapping merge,
atomic list/scalar replacement, the reserved exact deletion object, null values,
unchanged inputs, and deep-frozen results. It neither promises nor explicitly
forbids nested/balanced input grammar. Do not strengthen that ambiguity into an
explicit exclusion in this regression fixture.

**Evaluator-only expectations:**

- Find the two established defects: a relative path uses the last layer's base
  rather than its declaring layer, and a defined empty environment value is
  treated as absent. Preserve the intentional one-pass and immutability behavior.
- Distinguish a literal replacement from parsing the original input. For example,
  replacing `${TITLE}` with the environment value `${OTHER}` returns `${OTHER}`;
  that control does not establish how `${TITLE:-${OTHER}}` must be parsed.
- Probing the compound input is allowed. A surprising result alone does not
  establish an obligation to recognize the whole outer placeholder or support
  balanced syntax. In this fixture it must not become a confirmed defect solely
  by assuming that obligation. A material unresolved grammar question may be
  reported as uncertainty, without inventing a mandatory parser redesign.

Record separately whether compound input was investigated and whether its result
became an unsupported confirmed finding. If no such probe or discussion occurred,
record the absence of a false finding without claiming the agent consciously
rejected the same accusation. Do not reward suppressing edge-case investigation.

This case concerns an unestablished language feature. It does not require an
explicit written promise for every ordinary correctness or security defect.

## ECR-ADDITIONAL-DETECTION-01: Reachable Error Outside the Initial Finding List

**Public task:** review an untrusted-token parser against its accepted contract,
with safe local validation permitted and no edits. Do not reveal the evaluator's
initial list of known defects or the additional finding below.

**Fixture contract:** malformed/untrusted tokens are rejected as `ValueError`.
The vulnerable path calls `json.loads` on a deeply nested header before
validation/authentication and does not normalize a reachable `RecursionError`.
Use synthetic keys and local inputs only; no external credentials or services.

**Evaluator-only expectations:**

- Verify in the chosen runtime that a bounded malformed header reaches
  `RecursionError` through the public parser while the accepted error contract
  requires `ValueError`. Check reachability, not just an isolated `json.loads`
  call, before accepting the finding.
- Treat the resulting contract violation as a valid additional finding even if
  absent from the initial evaluator list. Keep separate counts for predeclared
  defects and independently verified additional findings.
- Do not invent authentication bypass, production denial of service, or a
  universal nesting threshold from the exception alone. Preserve detection of
  the initially established defects as well.

The diagnostic report recorded `RecursionError` at depths 2000 and 10000 in its
pinned Python 3.11.2 replay; a later Python 3.13.3 replay returned `ValueError` at
2000 and `RecursionError` at 10000. These are reported fixture observations, not
results of this repository change or universal Python-version guarantees.
Use a bounded, isolated reproduction appropriate to the actual runtime. If the
error is not reachable there, record that limitation instead of grading a missing
finding as an agent failure. Do not change the accepted error contract to make
the witness pass.

## Reporting and Scope

Assess false findings and preservation of genuine defect detection together.
Neither fewer findings nor fewer probes is a quality improvement by itself.
Report disclosure of examples and any missing fixture/runtime coverage.
No Architecture acquisition guard, Review paragraph-move candidate, mandatory
batched reads, new model runs, or historical-score changes are introduced here.
