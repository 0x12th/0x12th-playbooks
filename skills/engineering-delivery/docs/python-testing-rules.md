# Python Testing Rules

Use these rules with `testing-rules.md` for Python test and regression work.
Choose the test level from the target regression; Python-specific tools do not
change the general behavior-first contract.

## Fixtures and Test Data

Use fixtures to create meaningful, valid states:

- real domain objects and configuration;
- `tmp_path` for temporary filesystem behavior;
- a temporary database with real transactions;
- the real application container when it remains fast and deterministic.

Do not use fixtures only to bypass constructors. Prefer factories or builders
for larger test data. They should create valid defaults and allow overriding
only fields relevant to the scenario.

## Real Collaborators

Prefer a real Python collaborator when it is deterministic, fast, easy to
construct, and has no irreversible side effects. Common examples include
serializers, filesystem storage rooted at `tmp_path`, and a SQLite repository
using a temporary database.

For a service that coordinates these collaborators, assert the returned
result, persisted rows, written files, emitted events, or promised failure
state. Do not replace each collaborator with a mock merely to shorten setup.

## Test Doubles and `monkeypatch`

Use `monkeypatch` for controlled process or external boundaries such as:

- time and randomness;
- environment variables;
- OS interaction;
- network and external APIs;
- irreversible side effects.

Do not monkeypatch internal collaborators by default. Introduce or use a real
construction seam when that is a small, behavior-preserving change.

A narrow legacy exception is allowed when an internal collaborator is
hard-wired and introducing a seam would require disproportionate unrelated
refactoring. In that case:

- explain why the exception is necessary;
- patch the narrowest stable binding point;
- keep the real subject under test;
- assert public behavior or observable side effects;
- avoid deep mock graphs and exact internal call-order assertions;
- state the remaining coupling when it materially limits refactoring safety.

The exception makes legacy behavior testable; it does not make internal
monkeypatching the preferred design.

## Boundary Examples

| Risk | Preferred test |
|---|---|
| Pure transformation | Unit test with parameterized real inputs |
| Service + SQLite repository | Component test with a temporary database |
| Service + filesystem storage | Component test rooted at `tmp_path` |
| External HTTP API | Real adapter with a fake server or transport stub |
| Hard-wired legacy collaborator | Characterization test with a narrow, explained `monkeypatch` |
