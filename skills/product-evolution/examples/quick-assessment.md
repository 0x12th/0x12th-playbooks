# Quick Assessment Example

User request:

```text
A customer wants CSV export for every analytics table. Should we build it?
```

Output:

```markdown
Recommendation: Pilot First — validate one reporting workflow before committing to broader exports.
Confidence: Low; only the feature request is known.
Roadmap placement: Conditional; urgency and existing commitments are unknown.

Problem:
The requested solution is known; the underlying job is not. If the customer needs
to move data into a recurring reporting workflow, a narrow export may solve it.
Confirm which report and downstream task are blocked before choosing scope.

Who gets value:
The requesting customer is the only confirmed source of demand. User role,
account segment, and repeat demand are unknown.

Current workaround:
Unknown. Check whether manual export, API access, or saved reports already cover
the named task; that may make a product change unnecessary.

Why not the full request:
CSV export on every table creates broad surface area, permission questions,
support cases about formatting, and ongoing maintenance. It may also train users
to leave the product for analysis.

Smallest useful version:
Once the blocked task is confirmed, try a support-assisted export of one report.
If repeated use justifies a product change, add export for that report with current
filters and permission checks. A confirmed renewal deadline may raise urgency.

Tradeoff:
We can test whether a narrow export unblocks the customer and learn about demand.
We avoid turning every table into a supported data product. We delay generalized export
infrastructure until usage proves the need.

Risks and unknowns:
- Unknown whether this is one account or a repeated segment need.
- Permission and PII rules may make "export everywhere" unsafe.
- The real need might be scheduled delivery or API access, not CSV.

Proposed pilot criteria (agree with the customer before starting):
- The export completes the named downstream task with less manual work.
- Repeated use warrants automating the support-assisted export.
- Permission checks preserve the report's existing access rules.
Numeric targets and a measurement window need the workflow baseline.

Do not do now:
- Do not add exports to every table.
- Do not build scheduled exports until repeated manual export usage is proven.
```
