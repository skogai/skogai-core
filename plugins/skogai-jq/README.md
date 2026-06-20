# skogai-jq

Schema-driven jq/JSON transformation library for the skogai marketplace.

**Status: early migration.** The shared JSON hook runtime is active; the transform library still migrates from `todo/skills/skogai-jq/`.

## Layout

- `skills/skogai-jq/` — routing skill for the transform library
- `scripts/skogai-jq.sh` — shared JSON input, logging, context, and decision helpers for hooks
- `transforms/` — one directory per transform: `transform.jq`, `schema.json`, `test.sh`, `test-input-*.json`

Bats suites for this plugin live in the skogai-tests plugin under `tests/skogai-jq/`.
