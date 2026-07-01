---
type: skill
name: skogai-tests
description: This skill should be used when the user asks to "run tests", "add a test", "test a hook script", "test a jq transform", "validate a transform schema", or needs to route testing work across generated transform tests, Bats runtime contracts, hook integration tests, or real-history corpus passes.
---

<objective>
Route test work to the smallest layer that proves the behavior, then run every broader layer required by the change. `tests/AGENTS.md` owns local rules and `tests/TESTING.md` owns the layered strategy.
</objective>

<quick_start>
1. Read `tests/AGENTS.md`, then use `tests/TESTING.md` to identify the owning test layer.
2. Add the smallest behavioral regression test: transform fixture, Bats runtime contract, hook integration case, or sanitized corpus fixture.
3. Run the focused test while iterating, then the broader validation required by the cadence table.
</quick_start>

<routing>

| intent | endpoint |
| --- | --- |
| Testing rules and commands | `tests/AGENTS.md` |
| Layer selection and validation cadence | `tests/TESTING.md` |
| Test a hook script | `tests/skogai-hooks/` |
| Test the shared jq runtime | `tests/skogai-jq/` |
| Test one jq transform | `plugins/skogai-jq/transforms/<name>/` |
| Run Bats suites | `/run-tests` |
| Validate real history | Corpus runner documented by the owning migration or release workflow |

</routing>

<success_criteria>

- Tests exercise public scripts and assert meaningful content, selection, routing, or output shape.
- Generated expectations are regenerated from their owner rather than hand-edited.
- Corpus failures are sanitized and reduced into permanent fast fixtures.
- Validation reports distinguish focused, generated, Bats, and corpus results.

</success_criteria>
