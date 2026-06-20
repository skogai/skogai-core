---
type: skill
name: skogai-tests
description: Writes and runs bats test suites for skogai plugins. Use when writing tests for hook scripts or jq transforms, debugging failing bats tests, or adding a test suite for a new plugin.
---

<objective>
Own bats-based testing for skogai plugins. Tests live in this plugin, organized as one subfolder per plugin under test (`tests/skogai-hooks/`, `tests/skogai-jq/`). The current focus is the hooks, tested together with jq.
</objective>

<quick_start>
1. Find or create the subfolder for the plugin under test.
2. Write a `.bats` file using the run + assert pattern, loading the shared `test-helper`.
3. Run with `bats tests/**/*.bats`.
</quick_start>

<routing>

| intent | endpoint |
| --- | --- |
| Test a hook script | `tests/skogai-hooks/` |
| Test a jq transform | `tests/skogai-jq/` |
| What to test and what not to test | `tests/CLAUDE.md` |
| Run the full suite | `/run-tests` |

</routing>

<success_criteria>

- Tests assert content selection and output shape via jq extraction, not grep.
- No tests that merely re-verify the structured IO contract or that bash works.

</success_criteria>
