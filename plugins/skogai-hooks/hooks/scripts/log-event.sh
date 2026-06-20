#!/usr/bin/env bash
# Logs every hook invocation to a global JSONL file, then exits without
# emitting output or blocking — pure observation, no behavior change.
set -euo pipefail

log_dir="${SKOGAI_HOOKS_LOG_DIR:-$HOME/.claude/logs}"
log_file="$log_dir/hooks.jsonl"

input=$(cat)

mkdir -p "$log_dir"

{
  jq -nc \
    --arg logged_at "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
    --argjson input "$input" \
    '{
      logged_at: $logged_at,
      hook_event_name: ($input.hook_event_name // "Unknown"),
      session_id: ($input.session_id // "unknown"),
      input: $input
    }' >> "$log_file"
} &
disown

exit 0
