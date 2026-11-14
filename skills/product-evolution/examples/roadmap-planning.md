# Roadmap Planning Example

User request:

```text
Prioritize: onboarding checklist, team permissions, AI summary, public API.
Our goal this quarter is activation and paid team adoption; there are no other
committed roadmap items. Capacity covers the checklist now and permissions next.
Observed onboarding sessions stall before the first project; testing a checklist
removed that confusion. Two paid team trials need only owner/member permissions.
Two accounts will join an API pilot; we have no repeated demand for AI summaries.
The team's preliminary effort estimates are S/M/M/L for checklist/permissions/
AI summary/API; expected support load is low/medium/medium/high respectively.
```

Output:

```markdown
Recommendation:
1. Onboarding checklist
2. Team permissions
3. Public API as a pilot
4. Defer AI summary

Decision criteria:
Prioritize activation and paid team adoption before broad platform expansion or
AI features with unclear repeated use.

Ranking:
| Rank | Initiative | Recommendation | Why | Roadmap bucket |
|---:|---|---|---|---|
| 1 | Onboarding checklist | Do | Direct activation lever; likely small; easy to measure. | Now |
| 2 | Team permissions | Do Smaller | Blocks two paid trials; start with owner/member roles. | Next |
| 3 | Public API | Pilot First | Could unlock power users, but support and contract burden may be high. | Conditional on capacity after permissions |
| 4 | AI summary | Defer | Value is plausible but less tied to activation or revenue. | Parking Lot |

Scorecard (value and fit are estimates against the stated goal; effort and support
load use the team's preliminary estimates):
| Initiative | Value | Confidence | Effort | Support load | Strategic fit | Main risk |
|---|---|---|---|---|---|---|
| Onboarding checklist | High | Medium | S | Low | High | May optimize the wrong activation step. |
| Team permissions | High | Medium | M | Medium | High | Scope can expand into complex RBAC. |
| Public API | Medium | Low | L | High | Medium | Creates long-term platform support obligations. |
| AI summary | Medium | Low | M | Medium | Low | Novelty without repeated workflow pull. |

Sequence:
1. Ship the tested onboarding checklist and measure whether more users reach the
   first project before expanding it.
2. Add the owner/member permissions needed by the two paid trials before expanding
   the role model.
3. Run a limited API pilot with the two interested accounts before building public API docs,
   keys, rate limits, and support processes.

Defer or reject:
- AI summary: revisit only if users repeatedly ask for summarization inside a
  high-frequency workflow or if activation data shows a clear comprehension gap.

Evidence needed:
- Activation effect after shipping the checklist.
- Whether owner/member roles unblock the two paid trials.
- Pilot usage and support effort before committing to a public API.
```
