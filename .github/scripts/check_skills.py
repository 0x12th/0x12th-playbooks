#!/usr/bin/env python3
"""Repository consistency checks for skill metadata."""
import json
import re
import sys
from pathlib import Path
ROOT = Path(__file__).resolve().parents[2]
MANIFEST = ROOT / "manifests" / "skills.json"
README = ROOT / "README.md"
FILES_WITH_INSTALL_EXAMPLES = [README, ROOT / "docs" / "installation.md", MANIFEST]
FORBIDDEN_INSTALL = "cp" + " -R"
RAW_URL_RE = re.compile(r"https://raw\.githubusercontent\.com/0x12th/0x12th-playbooks/[^)\s\"']+")
MODE_RE = re.compile(r"- \*\*(.+?)\*\*:")

def norm(value: object) -> str:
    return re.sub(r"\s+", " ", str(value).strip().lower()).strip(" .")

def rel(path: Path) -> str:
    try:
        return str(path.relative_to(ROOT))
    except ValueError:
        return str(path)

def skill_modes(path: Path) -> list[str]:
    modes, in_modes = [], False
    for line in path.read_text(encoding="utf-8").splitlines():
        stripped = line.strip()
        if stripped in {"## Mode Selection", "## Work Modes"}:
            in_modes = True
            continue
        if in_modes and stripped.startswith("## "):
            break
        if in_modes and (match := MODE_RE.match(stripped)):
            modes.append(norm(match.group(1)))
    return modes

def local_raw_path(url: str) -> Path | None:
    prefix = "https://raw.githubusercontent.com/0x12th/0x12th-playbooks/"
    if not url.startswith(prefix):
        return None
    parts = url.removeprefix(prefix).split("/", 1)
    return ROOT / parts[1] if len(parts) == 2 else None

def main() -> int:
    errors = []
    try:
        manifest = json.loads(MANIFEST.read_text(encoding="utf-8"))
    except Exception as exc:
        print(f"ERROR: cannot read manifest: {exc}", file=sys.stderr)
        return 1
    skills = manifest.get("skills")
    if not isinstance(skills, list):
        errors.append("manifest: `skills` must be a list")
        skills = []
    names, manifest_paths = set(), set()
    for skill in skills:
        if not isinstance(skill, dict):
            errors.append("manifest: every skill must be an object")
            continue
        name, manifest_path = str(skill.get("name", "<missing>")), str(skill.get("path", ""))
        path = ROOT / manifest_path
        manifest_paths.add(manifest_path)
        if name in names:
            errors.append(f"manifest: duplicate skill name {name}")
        names.add(name)
        if not path.exists():
            errors.append(f"{name}: missing skill file {rel(path)}")
            continue
        actual = [norm(mode) for mode in skill.get("modes", [])]
        expected = skill_modes(path)
        if actual != expected:
            errors.append(f"{name}: modes mismatch; manifest={actual}, skill={expected}")
    actual_paths = {str(path.relative_to(ROOT)) for path in (ROOT / "skills").glob("*/SKILL.md")}
    for path in sorted(actual_paths - manifest_paths):
        errors.append(f"manifest: missing skill entry for {path}")
    for path in FILES_WITH_INSTALL_EXAMPLES:
        if FORBIDDEN_INSTALL in path.read_text(encoding="utf-8"):
            errors.append(f"{rel(path)}: installation examples must not use {FORBIDDEN_INSTALL}")
    readme_text = README.read_text(encoding="utf-8")
    for name in sorted(names):
        if name not in readme_text:
            errors.append(f"README.md: missing {name}")
    raw_urls = sorted(set(RAW_URL_RE.findall(readme_text + "\n" + json.dumps(manifest))))
    if not raw_urls:
        errors.append("No raw.githubusercontent.com skill URLs found")
    for url in raw_urls:
        local_path = local_raw_path(url)
        if local_path is None:
            errors.append(f"Malformed raw URL: {url}")
        elif not local_path.exists():
            errors.append(f"Raw URL points at missing local file: {url}")
    if errors:
        for error in errors:
            print(f"ERROR: {error}", file=sys.stderr)
        return 1
    print("Skill checks passed.")
    return 0

if __name__ == "__main__":
    raise SystemExit(main())
