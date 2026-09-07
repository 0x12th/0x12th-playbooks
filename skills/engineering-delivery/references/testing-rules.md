# Testing Rules

Tests should protect observable behavior, boundaries, contracts, and failure
modes. They should remain useful through safe refactoring instead of encoding
the current implementation.

Before adding a test, answer:

1. What externally meaningful behavior does it protect?
2. What plausible regression would make it fail?
3. Where did the expected result come from?
4. Can that oracle fail independently from the implementation?
5. Does an existing test already protect the same observable result and failure domain?

If the answer describes only the current implementation, choose a better test
boundary or assertion. Add a test only for a distinct behavior, contract,
boundary, invariant, failure domain, or historical regression. Do not add one
when existing coverage protects the same result and failure domain with an
equally strong or stronger independent oracle.

## Independent Oracle

An oracle is the source of the expected result: an explicit requirement, known
example, protocol fixture, independently maintained reference data, or a
mathematical invariant. Identify that source, not just the expected literal.
An independently implemented cross-check is useful only if it can fail differently.

Expected values computed by the same algorithm, shared helper, production
logic, or a renamed copy of that logic are weak or self-referential. A recorded
production output is characterization evidence, not independent proof of correctness.
Replace or supplement it with an independently justified expectation.

Do not allow mock-verifies-mock: mock setup must not both dictate and prove the
result. Exercise the real subject's mapping, policy, side effect, or failure
handling against a separately specified contract. Likewise, a fixture must not
pre-establish the asserted outcome without meaningful production behavior;
fixture validity is a precondition, not the behavior test.

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

For important cross-layer behavior, retain at least one hermetic test through
the current producer -> reader -> consumer path, with an independent semantic
expectation. Separate green layer tests do not prove that path. Preserve this
protection when replacing or retiring fixtures; do not retain an obsolete
fixture merely to keep the behavior reachable.

## Prefer Behavior Over Implementation

Prefer assertions on:

- returned results;
- persisted state;
- emitted events;
- external protocol behavior;
- observable side effects and failure modes.

Do not test private helpers, internal state, or exact interactions merely to
freeze the implementation. A low-level algorithm with an independently
specified contract may warrant direct tests even if its symbol is private.
Keep exact call counts only when they have semantics such as retry, billing,
batching, idempotency, or rate/resource limits. Keep exact sequencing only when
order affects behavior: protocols, transactions, locks, lifecycle, or cleanup.

Prefer concrete semantic assertions over `is not None`, `isinstance`, `len > 0`,
or existence checks, unless presence, type, or cardinality itself is the
contract. Replace large snapshots with focused semantic assertions unless the
snapshot artifact itself is an externally reviewed contract.

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

Do not optimize for test count, assertion count, or line/branch coverage.
Balance regression confidence and refactoring safety with determinism, setup
cost, and suite execution time.

Different input values alone do not justify more cases. Parameterize meaningful
equivalence classes, boundaries, distinct branches, invariants, and failure
types; keep names that localize regressions rather than an opaque permutation
matrix. A branch alone is not a behavior contract.

Preserve separate tests for distinct failure semantics: rejection, persistence,
transactions, concurrency, security, protocols, supported compatibility,
resource limits, and numerical/scientific invariants. A broad integration test
does not automatically subsume these checks. Compare the actual path, observable
result, oracle strength, and failure domain before consolidating.

## Regression Prevention

- First check whether an existing behavioral test can be strengthened or
  extended to catch the reproduced regression instead of adding a near-duplicate.
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
- Do not delete, skip, or loosen tests to hide failures. Consolidation is valid
  when surviving tests demonstrably protect the same behavior and failure
  domain with no weaker oracle; obsolete behavior requires an explicit current
  contract change. Preserve uncertain contracts, and run the surviving suite.

## Missing Test Infrastructure

If tests cannot be added or run, state why and use the next best validation
path.
