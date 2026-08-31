# Prepared Review Comment Template

Use one record per prepared comment. Preparation is dry-run.

```text
status: prepared
provider: <instance and provider type>
target: <canonical project/change ID>
snapshot: <full pinned version vector>
placement: inline candidate | general candidate
location: <current source path and line or general-comment context>
finding: <stable local finding ID>
body: <final concise comment body>
audience: <expected destination audience>
audience restriction: none | private evidence | security-sensitive
```

After the records, state:

```text
Prepared only; external provider actions are outside this skill.
```

Do not add severity labels or formal headings to the comment body unless the user or repository convention explicitly requires them. Keep structured metadata outside the rendered body.
