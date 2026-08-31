# Prepared Review Comment Template

Use one record per proposed provider operation. Preparation is dry-run.

```text
status: prepared
provider: <instance and provider type>
target: <canonical project/change ID>
snapshot: <full pinned version vector>
placement: inline | general
location: <native verified position or general-comment target>
finding: <stable local finding ID>
body: <final concise comment body>
audience: <expected destination audience>
publication restriction: none | private evidence | security-sensitive
fallback: none; do not silently change placement
```

After the records, state:

```text
Prepared only; nothing was posted, approved, requested, resolved, or merged.
```

Do not add severity labels or formal headings to the comment body unless the user or repository convention explicitly requires them. Keep structured metadata outside the rendered body.
