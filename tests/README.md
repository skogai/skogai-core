# skogai-tests

Bats testing plugin for the skogai marketplace. Holds the testing skill, the `/run-tests` command, and the test suites themselves — one subfolder per plugin under test.

**Status: early migration.** The canonical suite covers basic hook logging and the shared jq hook runtime; the larger hook and transform backlog remains under `todo/tests/` until migrated.

## Layout

- `skills/skogai-tests/` — bats testing skill
- `commands/run-tests.md` — `/run-tests` command
- `skogai-hooks/` — test suites for the skogai-hooks plugin
- `skogai-jq/` — test suites for the skogai-jq plugin
- `AGENTS.md` — scoped contributor and agent rules
- `TESTING.md` — test layers, ownership, and validation cadence
- `CLAUDE.md` — Claude-specific pointer to the canonical guidance

Run the current suite with `bats tests/**/*.bats` from the repository root.

## Migration backlog (from `todo/tests/`)

- `session-start`, `pre-tool-use`, `post-tool-use`, `stop`, `user-prompt-submit`, `worktree`, `workflow-memory` suites → `tests/skogai-hooks/`
