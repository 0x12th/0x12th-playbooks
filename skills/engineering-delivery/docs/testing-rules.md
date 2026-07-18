# Testing Rules

Tests should protect observable behavior, boundaries, contracts, and failure
modes. They should remain useful through safe refactoring instead of encoding
the current implementation.

Before adding a test, answer:

```text
What regression would this test catch?
```

If the answer describes only the current implementation, choose a better test
boundary or assertion.

## Add Tests When

- Fixing a bug with a reproducible failure.
- Changing behavior.
- Touching shared logic.
- Changing contracts, validation, parsing, persistence, or error handling.
- Refactoring code that lacks obvious safety.

## Choose the Narrowest Useful Level

Select the smallest test boundary that can reliably catch the target
regression:

- **Unit:** pure functions, algorithms, and isolated business rules.
- **Component:** a small group of real collaborating internal components.
- **Integration or contract:** databases, protocols, queues, and other real
  boundaries.
- **End to end:** critical user workflows when narrower tests cannot provide
  sufficient confidence.

Do not force every problem into a unit test, and do not prefer component tests
when a focused unit test proves the behavior. Let risk, blast radius,
determinism, and repository conventions determine the level.

## Prefer Behavior Over Implementation

Prefer assertions on:

- returned results;
- persisted state;
- emitted events;
- external protocol behavior;
- observable side effects and failure modes.

Avoid assertions on private method calls, helper order, or exact mock
interactions unless the interaction itself is the public contract.

Use real internal dependencies when they are deterministic, fast, easy to
construct, and free of irreversible side effects. A real domain object,
serializer, temporary filesystem, local database transaction, or small
dependency graph often provides more confidence than a mock graph.

At external or nondeterministic boundaries, use the smallest controlled test
double that preserves the behavior under test:

- a fake for a working in-memory implementation;
- a stub for controlled responses;
- a mock only when the interaction contract is the behavior being verified.

## Prioritize Valuable Tests

When multiple tests are possible, rank them:

1. Essential regression tests.
2. High-value behavior tests.
3. Nice-to-have edge cases.

Do not add low-value tests only to increase coverage. Balance regression
confidence and refactoring safety with determinism, setup cost, and suite
execution time.

## Regression Prevention

- A reproduced bug should usually leave behind a test, fixture, validator, or
  documented manual check.
- Repeated CI failures should become a clearer test failure, deterministic
  fixture, focused validator, or validation script when practical.
- If adding a test requires disproportionate scaffolding, explain the next best
  protection instead of constructing a brittle harness.

## Test Repair

When fixing failing tests:

- Identify whether the test or product behavior is wrong.
- Do not weaken assertions to make tests pass.
- Preserve meaningful coverage.
- Update snapshots only when the behavior change is intentional.
- Do not delete, skip, or loosen tests unless the tested behavior is
  intentionally obsolete and replacement coverage is clear.

## Missing Test Infrastructure

If tests cannot be added or run, state why and use the next best validation
path.
