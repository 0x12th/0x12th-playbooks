# Task Breakdown Template

Use this template to convert architecture findings into implementation-ready tasks.

## Task: <Short actionable title>

**Related finding:**  
**Severity addressed:** Critical | High | Medium | Low  
**Goal:**


**Why this matters:**


**Evolution cost:**

- Operational cost:
- Team cognitive load:
- Migration cost:
- 1–3 year maintenance impact:
- Complexity delta:

**Ownership / organizational impact:**


**Performance impact:**


**Scope:**

In scope:

- 

Out of scope:

- 

**Implementation steps:**

1. 
2. 
3. 

**Validation plan:**

- Unit tests:
- Integration/contract tests:
- Manual or smoke checks:
- Observability checks:

**Migration / rollout plan:**

- Can old and new paths coexist?
- What is the phased rollout sequence?
- How will correctness be validated during rollout?
- What observability is required?

**Rollback or mitigation plan:**

- 

**Dependencies:**

- 

**Acceptance criteria:**

- [ ] Behavior is preserved or intentionally changed and documented.
- [ ] Relevant tests pass.
- [ ] Deployment and rollback impact is understood.
- [ ] Migration path supports coexistence or explicitly explains why not.
- [ ] Correctness validation is defined for migrations or behavior changes.
- [ ] Logs/metrics/traces are updated if operational behavior changes.
- [ ] Performance impact and resource utilization are understood where relevant.
- [ ] Ownership and maintenance responsibilities are clear.
- [ ] Documentation or ADR is updated if the decision affects future maintainers.

**Complexity:** Small | Medium | Large | Unknown  
**Change risk:** Low | Medium | High | Unknown
