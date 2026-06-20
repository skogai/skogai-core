#!/usr/bin/env bash
# UserPromptSubmit: log-only for now — no context injection, no prompt modification.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cat | "$SCRIPT_DIR/log-event.sh"
