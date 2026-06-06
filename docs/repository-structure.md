# Repository Structure

The repository is organized as a multi-skill library.

```text
0x12th-playbooks/
├── README.md
├── LICENSE
├── CHANGELOG.md
├── .github/
│   ├── scripts/
│   │   └── check_skills.py
│   └── workflows/
│       └── check-skills.yml
├── skills/
│   ├── engineering-architecture-review/
│   │   ├── SKILL.md
│   │   ├── docs/
│   │   ├── templates/
│   │   └── examples/
│   └── engineering-delivery/
│       ├── SKILL.md
│       ├── docs/
│       ├── templates/
│       └── examples/
├── manifests/
│   └── skills.json
└── docs/
    ├── agent-bootstrap.md
    ├── installation.md
    ├── skill-selection.md
    ├── repository-structure.md
    └── authoring-guidelines.md
```

## Skill Layout

Each skill has:

- `SKILL.md`: concise activation, boundaries, intent detection, mode/work selection, and references.
- `docs/`: detailed rules loaded on demand.
- `templates/`: reusable output templates.
- `examples/`: representative prompts and outputs.

Keep `SKILL.md` small. Move detailed rules into docs and link them directly from `SKILL.md`.

## Manifest

`manifests/skills.json` is machine-readable metadata for available skills, locations, use cases, non-use cases, installation, and selection hints.

Platform-specific manifests are intentionally not included because Zed, Claude Code, and Codex do not read them automatically.

## Validation

- `.github/scripts/check_skills.py`: validates skill modes, installation snippets, README skill references, and raw skill URL targets.
- `.github/workflows/check-skills.yml`: runs the same check in GitHub Actions.
