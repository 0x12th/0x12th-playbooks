# Agent Bootstrap

Use this short text in `AGENTS.md`, `CLAUDE.md`, or similar project instructions when installed skills are not reliably discovered. Maintainer routing semantics and examples live in [Skill Selection](skill-selection.md); the copied text has no dependency on repository docs.

```text
Use relevant installed 0x12th-playbooks skills by the primary requested decision:
- product-evolution: product value, investment, scope, priorities or explicit product health/adoption.
- engineering-architecture: technical design/evolution, generic project/repository review and readiness.
- engineering-code-review: read-only selected-code or concrete change-set review and dry-run review comments. Standalone code needs no Git/provider inventory.
- engineering-delivery: diagnosis, validation and authorized implementation. Diagnostic questions and assessment-only requests remain read-only; explicit requested outcomes requiring changes authorize scoped edits when the target is clear (including “доведи до рабочего состояния”, “сделай чтобы CI был зелёным”, “закончи задачу”). Release preparation is not permission to publish/push or act destructively.

Follow each skill's own triggers, mode selection and safeguards. Review-and-fix means a read-only evidence/findings phase, then bounded authorized implementation under delivery rules, not a required runtime switch/handoff. Disclose missing required guidance; preserve safe scope and user work. Resolve product/architecture decisions first only when needed.

Do not announce internal routing unless requested or required by the host.
```
