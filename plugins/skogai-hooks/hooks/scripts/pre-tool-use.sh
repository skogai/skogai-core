#!/usr/bin/env bash
# PreToolUse: log-only for now — no blocking, no input modification.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cat | "$SCRIPT_DIR/log-event.sh"
