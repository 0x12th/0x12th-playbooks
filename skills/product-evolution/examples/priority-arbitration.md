# Priority Arbitration Example

User request:

```text
Use product-evolution. Which should come first: autotests or new customer pilots?
```

Output:

```markdown
Recommendation: Autotests first, but only for pilot-critical flows
Decision: Do Smaller
Confidence: Medium

Competing priorities:
- Autotests
- New customer pilots

Winner:
Autotests should receive the first slice of capacity if current pilot delivery
is already slowed by regressions, manual QA, or fear of release breakage. The
right version is not a broad test initiative; it is a narrow reliability
investment around the flows that pilots depend on.

What waits:
New pilots should wait until the team can run them without multiplying manual QA
and support load. Existing pilots can continue if they do not require new product
surface area.

Comparison:
| Initiative | Expected value | Cost | Risk | Urgency | Roadmap impact | Customer impact | Team impact | Cost of delay |
|---|---|---|---|---|---|---|---|---|
| Pilot-critical autotests | High | M | Low | High | Protects pilot velocity | Fewer broken pilot experiences | Reduces release anxiety and repeated manual checks | Regression risk compounds with every new pilot |
| New customer pilots | Medium | M | Medium | Medium | Expands learning surface | Helps selected customers sooner | Increases coordination and support load | Some learning is delayed |

Rationale:
If pilots are the main learning engine, reliability around pilot-critical paths
is part of pilot capacity, not separate engineering polish. More pilots before
basic confidence can create noisy evidence: failures may reflect product quality,
not customer demand.

Smallest compromise:
Spend one short cycle on tests for the 3-5 flows every pilot uses, then admit one
new pilot account. Do not pause all discovery for a broad test suite.

Reversal conditions:
- If there have been no pilot-blocking regressions in the last cycle, start the
  next pilot and add tests only around newly touched flows.
- If a customer pilot has signed commercial urgency, run it with explicit support
  coverage and a tight scope.

Next step:
Define the pilot-critical flows and success gate: release pilot changes without
manual regression checks for those flows for two consecutive releases.
```
