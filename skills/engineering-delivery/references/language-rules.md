# Language Rules

Chat responses use the language of the actual request unless the user asks for
another language. Mixed quoted material does not change the chat language.

Commit messages, MR/PR descriptions and other project artifacts select their
language separately: explicit instruction for that artifact, documented project
rules, stable recent practice for that artifact type, then request language.
Surface conflicts with mandatory policy rather than silently bypassing it.
Do not use README language alone to override the venue's established practice.

Use the chosen language for the artifact's title, ordinary section headings and
body. Translate optional template labels, but preserve exact mandatory fields,
automation markers, quotations, errors, identifiers and established terms.

Commit descriptions begin with a lowercase action verb: Russian past-tense
singular without `я`, English imperative. Preserve proper names, abbreviations
and required tokens such as `BREAKING CHANGE`; do not lowercase entire messages.
The delivery core and `communication-rules.md` define artifact details.
