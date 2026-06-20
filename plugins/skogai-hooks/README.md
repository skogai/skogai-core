# skogai-hooks

Reusable Claude Code lifecycle hooks for the skogai marketplace.

**Status: scaffold + logging.** SessionStart is still a silent placeholder. PreToolUse, PostToolUse, and UserPromptSubmit are wired to a pass-through logger: each event's full input JSON is appended to a global JSONL log and then forwarded unchanged — no blocking, no modification, fire-and-forget.

## Layout

- `hooks/hooks.json` — hook event wiring (auto-discovered)
- `hooks/scripts/` — hook scripts, referenced via `${CLAUDE_PLUGIN_ROOT}`
  - `pre-tool-use.sh`, `post-tool-use.sh`, `user-prompt-submit.sh` — thin, event-specific entry points (each owns its own input/output contract so event-specific logic can be added later); for now each just pipes stdin to `log-event.sh`
  - `log-event.sh` — shared logger: reads the input JSON, appends `{logged_at, hook_event_name, session_id, input}` to the log file in a backgrounded subshell, emits nothing, exits 0

### Logging

Log file: `${SKOGAI_HOOKS_LOG_DIR:-$HOME/.claude/logs}/hooks.jsonl` — one growing global file across all projects/sessions. Override the directory with the `SKOGAI_HOOKS_LOG_DIR` env var.

Bats suites for this plugin live in the skogai-tests plugin under `tests/skogai-hooks/`.

## Migration backlog (from `todo/hooks/`)

session-start, session-end, pre-tool-use, post-tool-use, post-tool-use-failure, stop, stop-git-dirty, stop-quality-gate, user-prompt-submit, pre-compact, notification, permission-request, config-change, subagent-start, subagent-stop, task-completed, teammate-idle, worktree-create, worktree-remove, lesson_matcher.py
