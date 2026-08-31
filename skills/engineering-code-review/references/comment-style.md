# Review Comment Style

Rendering is separate from the structured finding record. Severity, disposition, confidence, evidence, and impact remain in the report without making inline comments sound formal or generated.

Style priority:

```text
explicit user style
-> repository/team review conventions
-> built-in concise-peer profile
```

## concise-peer

The built-in `concise-peer` profile is a default baseline, not a claim to imitate one person's identity exactly. For Russian comments, use these requirements:

- Коротко и по делу. Обычно 1–3 предложения.
- Разговорный технический русский без канцелярита.
- Тон спокойный и неформальный, как между разработчиками одной команды.
- Не пытайся звучать как формальный ревьюер или документация.
- Допустимы разговорные конструкции: «тут лучше...», «я бы...», «кажется...», «а зачем тут...?», «может проще...?», «не понял, зачем...», «давай лучше...».
- Если проблема очевидна — говори прямо, без длинного вступления.
- Если решение спорное — формулируй как вопрос или предложение, а не как категоричное требование.
- Не пересказывай код и не объясняй очевидное.
- Объясняй причину замечания, если без неё непонятно, зачем что-то менять.
- Если предлагаешь изменение, по возможности сразу дай простой вариант решения.
- Не раздувай архитектурные замечания: сначала обозначь конкретную проблему, затем кратко предложи направление исправления.
- Используй профессиональные термины естественно: MR, API, DI, мок, фикстура, контракт, ретрай, таймаут, хендлер и т.п. Не заменяй привычные команде термины искусственно русскими аналогами.
- Не используй шаблонные фразы вроде «рекомендуется рассмотреть», «следует обратить внимание», «данный подход», «с точки зрения best practices», «для улучшения читаемости и поддерживаемости».
- Не начинай комментарии с похвалы или формальностей.
- Не добавляй заголовки вроде «Проблема», «Предложение», «Рекомендация».
- Не используй эмодзи.
- Не ставь точку в конце короткого однострочного комментария, если без неё текст выглядит естественно.
- Не пиши длинное объяснение, если достаточно вопроса.
- Перед отправкой мысленно сократи комментарий: если предложение можно удалить без потери смысла — удали.

Examples:

```text
а зачем тут отдельный try? выше же уже ловим эту ошибку

я бы это вынес из хендлера, а то он уже начинает знать слишком много

может проще через фикстуру это сделать? сейчас в каждом тесте одна и та же подготовка

тут ретрай точно нужен? если операция не идемпотентная, можем два раза выполнить

не понял, зачем нам тут Optional, ниже None всё равно не обрабатывается

давай это хотя бы в отдельный метод вынесем, сейчас основная логика теряется

кажется, это лучше проверять на границе API, дальше по коду уже можно считать контракт валидным

а если сервис тут упадет по таймауту? мы в итоге весь запрос положим?

это лучше не мокать. по факту тогда тест проверяет наш же мок, а не поведение
```

For other languages preserve the same concise peer-to-peer characteristics rather than translating Russian constructions mechanically.

A true personal style profile requires 15–30 real review comments supplied or explicitly selected by that user. Do not fabricate a personal corpus or infer it from a few examples.

## Anti-examples

Too formal:

> Рекомендуется рассмотреть возможность вынесения данной логики в отдельный метод для улучшения читаемости и поддерживаемости

Too long for the point:

> Тут потенциально может возникнуть проблема, потому что в случае определённого набора входных данных код, вероятно, поведёт себя не так, как ожидается, поэтому я бы предложил дополнительно подумать над обработкой этого сценария

Unsupported certainty:

> это точно упадёт в проде, надо переделать

Code restatement without a reason:

> здесь вызывается `save()`, а потом возвращается результат

Artificial contrast used as a rhetorical template:

> это не просто проверка, а нарушение контракта

Mechanical conversational markers:

> кажется, тут, может, я бы всё-таки, наверное, вынес это

Do not mechanically alternate `тут`, `я бы`, `может`, and `кажется`. Use a conversational marker only when it matches the finding's confidence and makes the comment shorter.

## Language Selection

Choose comment language in this order:

1. Explicit user request.
2. Stable language of current MR/PR and discussions.
3. MR/PR description language.
4. English fallback.

Chat reports follow the user's current language. Preserve identifiers, error messages, and exact code quotations.

## Rendering Rules

- Usually use one to three sentences.
- State confirmed defects directly.
- Use a question or proposal only for genuine tradeoffs or missing evidence.
- Include a simple fix direction when it is obvious.
- Do not restate code, add praise, use emoji, or add formal headings.
- Remove every sentence that does not change the meaning.

Prepared comments stay provider-neutral. Native suggestion syntax and position mapping belong to a provider-specific adapter.
