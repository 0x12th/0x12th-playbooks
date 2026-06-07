# Roadmap Planning Example

User request:

```text
Prioritize: onboarding checklist, team permissions, AI summary, public API.
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
| 2 | Team permissions | Do Smaller | Needed for team adoption, but start with 2-3 roles. | Now/Next |
| 3 | Public API | Pilot First | Could unlock power users, but support and contract burden may be high. | Next |
| 4 | AI summary | Defer | Value is plausible but less tied to activation or revenue. | Parking Lot |

Scorecard:
| Initiative | Value | Confidence | Effort | Support load | Strategic fit | Main risk |
|---|---|---|---|---|---|---|
| Onboarding checklist | High | Medium | S | Low | High | May optimize the wrong activation step. |
| Team permissions | High | Medium | M | Medium | High | Scope can expand into complex RBAC. |
| Public API | Medium | Low | L | High | Medium | Creates long-term platform support obligations. |
| AI summary | Medium | Low | M | Medium | Low | Novelty without repeated workflow pull. |

Sequence:
1. Ship onboarding checklist because it improves activation and creates better
   funnel data for later roadmap decisions.
2. Add minimal team permissions only after defining the roles required by paid
   accounts.
3. Run a limited API pilot with 2-3 accounts before building public API docs,
   keys, rate limits, and support processes.

Defer or reject:
- AI summary: revisit only if users repeatedly ask for summarization inside a
  high-frequency workflow or if activation data shows a clear comprehension gap.

Evidence needed:
- Activation drop-off point for onboarding.
- Number of paid/team deals blocked by permissions.
- Count and quality of API requests by account segment.
```
