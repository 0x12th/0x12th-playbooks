# Architecture Review Report Template

This template adds report detail to the `SKILL.md` result contract; it does not
override it. Retain only useful sections and fields. Every significant
recommendation, including roadmap items, needs confidence and a technical
disposition from the core contract.

Verdict: <mode-appropriate decision>

## 1. Decision Summary

- Highest-risk issue:
- Best near-term improvement:
- Main uncertainty:
- Change to avoid because cost exceeds benefit:

## 2. Scope and Assumptions

**Scope reviewed:**

- 

**Out of scope:**

- 

**Assumptions:**

- 

**Evidence inspected:**

- Code paths:
- Config/deployment files:
- Tests:
- Docs/ADRs:
- Runtime or operational artifacts:
- Ownership or team-boundary evidence:
- Performance or capacity evidence:
- Migration-related evidence:

## 3. Concise Architecture Model

**System purpose:**


**Major components/modules/services:**

| Component | Responsibility | Key dependencies | Notes |
|---|---|---|---|
|  |  |  |  |

**Primary data ownership:**

| Data/domain area | Owner/module/service | Storage | Consumers |
|---|---|---|---|
|  |  |  |  |

**Important flows:**

1. 

**Deployment/runtime shape:**


**Observability and operations:**


**Ownership and organizational boundaries:**


**Performance-sensitive paths and capacity constraints:**


**Migration context or likely evolution paths:**


## 4. Findings

### Finding 1: <Title>

**Severity:** Critical | High | Medium | Low  
**Confidence:** High | Medium | Low — evidence or limitation

**Technical disposition:** Required before implementation | Next safe step | Defer pending evidence | Do not implement

**Evidence:** Files, modules, configs, tests, logs, or docs inspected

**Problem:**


**Impact:**


**Root cause:**


**Proposed solution:**


**Evolution cost:**

- Operational cost:
- Team cognitive load:
- Migration cost:
- 1–3 year maintenance impact:
- Complexity delta:

**Organizational considerations:**


**Migration and rollback considerations:**


**Performance considerations:**


**Complexity:** Small | Medium | Large | Unknown  
**Risk:** Low | Medium | High | Unknown  
**Expected benefit:**


## 5. Recommended Roadmap

### Now

- 

### Next

- 

### Later

- 

## 6. Validation and Remaining Uncertainty

**Validation performed:**

- 

**Unverified assumptions / missing context:**

- 

**Recommended follow-up checks:**

- 
