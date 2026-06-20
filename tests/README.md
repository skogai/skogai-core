# skogai-tests

Bats testing plugin for the skogai marketplace. Holds the testing skill, the `/run-tests` command, and the test suites themselves — one subfolder per plugin under test.

**Status: placeholder scaffold.** Suites currently focus on the hooks, together with jq.

## Layout

- `skills/skogai-tests/` — bats testing skill
- `commands/run-tests.md` — `/run-tests` command
- `skogai-hooks/` — test suites for the skogai-hooks plugin
- `skogai-jq/` — test suites for the skogai-jq plugin
- `CLAUDE.md` — what to test and what not to test

## Migration backlog (from `todo/tests/`)

- `test-helper.bash` → `tests/test-helper.bash`
- `session-start`, `pre-tool-use`, `post-tool-use`, `stop`, `user-prompt-submit`, `worktree`, `workflow-memory` suites → `tests/skogai-hooks/`
- `skogai-jq` suites → `tests/skogai-jq/`
