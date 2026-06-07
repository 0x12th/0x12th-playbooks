# Pilot Evaluation Example

User request:

```text
Sales wants us to build SSO for one enterprise prospect as a pilot.
```

Output:

```markdown
Recommendation: Pilot First, but only with a commercial gate
Confidence: Medium

Hypothesis:
If we support the prospect's SSO requirement with a narrow integration path, the
deal can close and the same capability will unblock similar enterprise deals.

Pilot cohort:
One named prospect plus 1-2 existing enterprise accounts that have asked about
SSO. A single prospect is not enough to justify a generalized enterprise auth
program.

Minimal pilot scope:
- One SAML or OIDC path, not both.
- Manual configuration by the team.
- Limited admin UI or no UI if support can configure safely.
- Audit the auth flow enough for security review.

Out of scope:
- Full self-serve identity-provider marketplace.
- SCIM provisioning.
- Group mapping.
- Multi-provider support.

Success gates:
- Prospect signs a paid contract or written pilot agreement before build starts.
- At least one other target account confirms the same SSO requirement.
- Pilot account completes login setup with fewer than 2 support interventions
  after initial configuration.

Kill criteria:
- Prospect will not commit commercially.
- Requirement expands to provisioning, group sync, or custom identity behavior.
- Security review identifies risk that cannot be handled in the pilot scope.

Expansion criteria:
If 3 enterprise accounts adopt the pilot flow and sales can tie it to pipeline,
promote SSO self-serve configuration to roadmap `Next`.

Post-pilot decision:
Do Smaller if commercial pull is confirmed. Defer if this remains a single
prospect accommodation.
```
