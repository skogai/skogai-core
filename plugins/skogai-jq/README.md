# skogai-jq

Schema-driven jq/JSON transformation library for the skogai marketplace.

**Status: placeholder scaffold.** The real transform library lives at `todo/skills/skogai-jq/` and migrates here.

## Layout

- `skills/skogai-jq/` — routing skill for the transform library
- `transforms/` — one directory per transform: `transform.jq`, `schema.json`, `test.sh`, `test-input-*.json`

Bats suites for this plugin live in the skogai-tests plugin under `tests/skogai-jq/`.
