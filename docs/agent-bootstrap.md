# Agent Bootstrap

Use this short text in `AGENTS.md`, `CLAUDE.md`, or similar project instructions when installed skills are not reliably discovered. Maintainer routing semantics and examples live in [Skill Selection](skill-selection.md); the copied text has no dependency on repository docs.

```text
Use relevant installed 0x12th-playbooks skills by the primary requested decision:
- product-evolution: product value, investment, scope, priorities or explicit product health/adoption.
- engineering-architecture: technical design/evolution, generic project/repository review and readiness.
- engineering-code-review: read-only selected-code or concrete change-set review and dry-run review comments. Standalone code needs no Git/provider inventory.
- engineering-delivery: diagnosis, validation, authorized implementation, commit messages and MR/PR descriptions. Diagnostic questions and assessment-only requests remain read-only; explicit requested outcomes requiring changes authorize scoped edits when the target is clear (including “доведи до рабочего состояния”, “сделай чтобы CI был зелёным”, “закончи задачу”). Release preparation is not permission to publish/push or act destructively.

Whenever drafting commit messages or MR/PR descriptions, including during coding or after review, apply delivery's artifact rules. Artifact language follows explicit artifact instructions, documented project policy, stable same-artifact history, then request language; chat language is independent. Surface conflicts with mandatory policy. Default to conventional commit prefixes and lowercase opening verbs: Russian past-tense singular without “я”, English imperative. Preserve identifiers, acronyms and required footer tokens. Use one language for ordinary MR/PR headings and body; explain why, what changed, how it matters and actual checks in plain concise prose. Drafting alone does not authorize committing, pushing or publication.

Follow each skill's own triggers, mode selection and safeguards. Review-and-fix means a read-only evidence/findings phase, then bounded authorized implementation under delivery rules, not a required runtime switch/handoff. Disclose missing required guidance; preserve safe scope and user work. Resolve product/architecture decisions first only when needed.

Do not announce internal routing unless requested or required by the host.
```
