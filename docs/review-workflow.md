# Feature Review Workflow

This unreleased workflow extends the four existing skills. Install the complete
bundle from the same revision; `v0.18.1` predates it. No additional agent framework,
model provider or reviewer plugin is required.

## Adoption

Delivery implements and validates the feature, then supplies its complete
captured result to a fresh reviewer using `engineering-code-review`. The reviewer
gets original requirements, accepted constraints and source evidence. An extra
simplicity/integration reviewer is useful for a named structural tradeoff, such
as a new state owner or compatibility path. Architecture Design Challenge can
answer that bounded decision. Reviews converge into one report.

Findings are checked before fixes. The normal budget is one full pass and one
targeted re-review. Remaining blockers and unavailable evidence stay visible.
Without fresh-context capability, use a separate self-review and preserve the
brief for an independent session; do not describe it as independent approval.
The runtime contract is in Delivery's completion-review section and reference;
the review brief is bundled with Code Review.

For learning from human feedback, start with a confirmed missed finding and its
original evidence. Propose a deterministic check for a mechanical mistake, a
short reviewer standard for a judgment call, or a context pointer for missing
information. Avoid expanding permanent instructions after every routine run.

## Optional Kodus / Kody Setup

Inspect the configuration used by your deployed version and repository before
changing it. A selected model does not establish what context or checks run.

- Check `repoInstructionsEnabled`, applicable project instruction files and
  the requirements/task source actually supplied to the reviewer.
- Check excluded paths, enabled `reviewOptions`, suggestion limits and
  `suggestionControl.severityLevelFilter`. Explain missing findings before
  raising severity or disabling useful noise filters.
- Add a small number of project-specific Kody Rules for recurring confirmed
  issues. State the affected scope, concrete consequence and a good/bad example.
  Keep optional simplification distinct from a merge blocker.
- Compare findings on the same revision with local independent review. Do not
  infer the cause of a difference from the model name or the tone of a comment.

Use the project's short review standards as the common source for local reviewers
and configured provider rules. Verify each tool actually loads the relevant
material; installing a local skill alone does not configure a remote reviewer.
This guide does not change a connected service or publish comments.

## Check the Benefit

Use a small set of past changes with confirmed missed findings and clean controls.
Review the original pre-fix snapshots in fresh contexts; keep old comments and
expected answers with the evaluator. Compare confirmed detection, misses, false
findings, review rounds and human time. A same-model fresh-context comparison is
a useful starting point before changing models. Do not equate more comments or
implementer agreement with quality. Use [Behavior Evaluation](behavior-evaluation.md)
for the maintainer method and capability coverage; local probes do not replace
the Codex/Hermes/Zed release gate.

## Source Approaches

These are design references, not runtime dependencies or verbatim policy imports:

- [Superpowers requesting-code-review](https://github.com/obra/superpowers/blob/main/skills/requesting-code-review/SKILL.md): independent evaluation with explicit requirements and revision range.
- [Anthropic feature-dev, quality review](https://github.com/anthropics/claude-plugins-official/blob/main/plugins/feature-dev/commands/feature-dev.md): separate correctness, simplicity and project-fit perspectives.
- [Matt Pocock code-review](https://github.com/mattpocock/skills/blob/main/skills/engineering/code-review/SKILL.md) and [retro](https://www.aihero.dev/skills-retro): requirements/standards checks and learning from confirmed misses.
- [Anthropic review practice](https://claude.dev/blog/solving-code-review-at-anthropic/): verification of findings, bounded re-review and evaluation against historical changes.
- [Kodus configuration](https://github.com/kodustech/kodus-ai/blob/main/default-kodus-config.yml) and [Kody Rules](https://kodus.io/en/setting-up-kody-rules-for-code-reviews/): version-specific configuration and scoped reviewer rules.
