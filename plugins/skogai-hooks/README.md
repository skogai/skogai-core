# skogai-hooks

Reusable Claude Code lifecycle hooks for the skogai marketplace.

**Status: placeholder scaffold.** Ships one silent SessionStart hook so the plugin installs and fires end-to-end.

## Layout

- `hooks/hooks.json` — hook event wiring (auto-discovered)
- `hooks/scripts/` — hook scripts, referenced via `${CLAUDE_PLUGIN_ROOT}`

Bats suites for this plugin live in the skogai-tests plugin under `tests/skogai-hooks/`.

## Migration backlog (from `todo/hooks/`)

session-start, session-end, pre-tool-use, post-tool-use, post-tool-use-failure, stop, stop-git-dirty, stop-quality-gate, user-prompt-submit, pre-compact, notification, permission-request, config-change, subagent-start, subagent-stop, task-completed, teammate-idle, worktree-create, worktree-remove, lesson_matcher.py
