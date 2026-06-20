#!/usr/bin/env bats

load ../test-helper

REPO_ROOT="$(cd "$(dirname "$BATS_TEST_FILENAME")/../.." && pwd)"
HOOK_ROOT="$REPO_ROOT/plugins/skogai-hooks/hooks"
SCRIPTS_DIR="$HOOK_ROOT/scripts"

setup() {
    setup_test_dir
    export LOG_FILE="$TEST_DIR/logs/hooks.jsonl"
}

teardown() {
    teardown_test_dir
}

invoke_hook() {
    local script="$1"
    local payload="$2"
    printf '%s' "$payload" | env SKOGAI_HOOKS_LOG_DIR="$TEST_DIR/logs" bash "$SCRIPTS_DIR/$script"
}

@test "log-event preserves PreToolUse command context" {
    local payload='{"hook_event_name":"PreToolUse","session_id":"session-123","tool_name":"Bash","tool_input":{"command":"git status"}}'

    run invoke_hook pre-tool-use.sh "$payload"
    assert_success
    wait_for_file "$LOG_FILE"

    run jq -r '[.hook_event_name, .session_id, .input.tool_name, .input.tool_input.command] | @tsv' "$LOG_FILE"
    assert_success
    assert_output_equals $'PreToolUse\tsession-123\tBash\tgit status'
}

@test "log-event preserves PostToolUse response context" {
    local payload='{"hook_event_name":"PostToolUse","session_id":"session-456","tool_name":"Read","tool_use_id":"toolu_123","tool_response":{"content":"done"}}'

    run invoke_hook post-tool-use.sh "$payload"
    assert_success
    wait_for_file "$LOG_FILE"

    run jq -r '[.hook_event_name, .session_id, .input.tool_use_id, .input.tool_response.content] | @tsv' "$LOG_FILE"
    assert_success
    assert_output_equals $'PostToolUse\tsession-456\ttoolu_123\tdone'
}

@test "log-event preserves UserPromptSubmit prompt context" {
    local payload='{"hook_event_name":"UserPromptSubmit","session_id":"session-789","prompt":"explain jq hooks"}'

    run invoke_hook user-prompt-submit.sh "$payload"
    assert_success
    wait_for_file "$LOG_FILE"

    run jq -r '[.hook_event_name, .session_id, .input.prompt] | @tsv' "$LOG_FILE"
    assert_success
    assert_output_equals $'UserPromptSubmit\tsession-789\texplain jq hooks'
}

@test "log-event appends one structured record per invocation" {
    run invoke_hook pre-tool-use.sh '{"hook_event_name":"PreToolUse","session_id":"session-a"}'
    assert_success
    run invoke_hook post-tool-use.sh '{"hook_event_name":"PostToolUse","session_id":"session-a"}'
    assert_success
    wait_for_lines 2 "$LOG_FILE"

    run jq -s -r '[length, .[0].hook_event_name, .[1].hook_event_name] | @tsv' "$LOG_FILE"
    assert_success
    assert_output_equals $'2\tPreToolUse\tPostToolUse'
}

@test "hook registry routes events through dedicated adapters" {
    local expected='${CLAUDE_PLUGIN_ROOT}/hooks/scripts/pre-tool-use.sh'
    expected+=$'\t${CLAUDE_PLUGIN_ROOT}/hooks/scripts/post-tool-use.sh'
    expected+=$'\t${CLAUDE_PLUGIN_ROOT}/hooks/scripts/user-prompt-submit.sh'

    run jq -r '[
        .hooks.PreToolUse[0].hooks[0].command,
        .hooks.PostToolUse[0].hooks[0].command,
        .hooks.UserPromptSubmit[0].hooks[0].command
    ] | @tsv' "$HOOK_ROOT/hooks.json"
    assert_success
    assert_output_equals "$expected"
}
