# Quick Assessment Example

User request:

```text
A customer wants CSV export for every analytics table. Should we build it?
```

Output:

```markdown
Recommendation: Do Smaller
Confidence: Medium
Roadmap placement: Next, unless this blocks an active renewal.

Problem:
The customer needs to move analytics data into their internal reporting workflow.
The request is phrased as "CSV export everywhere", but the underlying problem is
data portability for a recurring reporting job.

Who gets value:
Operations and analytics users in larger accounts. Value is strongest if several
accounts already copy data manually or ask for scheduled reporting.

Current workaround:
Likely manual copy/paste or screenshots. If the product already has API access,
the real gap may be onboarding, docs, or saved reports rather than exports.

Why not the full request:
CSV export on every table creates broad surface area, permission questions,
support cases about formatting, and ongoing maintenance. It may also train users
to leave the product for analysis.

Smallest useful version:
Add export only to the 2-3 highest-value reports, with current filters applied
and account-level permission checks. If urgency is renewal-driven, start with a
manual export or support-assisted report for that customer.

Tradeoff:
We gain faster customer unblock and evidence about export demand. We avoid
turning every table into a supported data product. We delay generalized export
infrastructure until usage proves the need.

Risks and unknowns:
- Unknown whether this is one account or a repeated segment need.
- Permission and PII rules may make "export everywhere" unsafe.
- The real need might be scheduled delivery or API access, not CSV.

Success criteria:
- At least 3 accounts use export repeatedly within 30 days.
- Support-assisted reporting requests decline for the exported reports.
- No permission or data leakage incidents.

Do not do now:
- Do not add exports to every table.
- Do not build scheduled exports until repeated manual export usage is proven.
```
