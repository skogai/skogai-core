---
type: skill
name: skogai-jq
description: Schema-driven jq/JSON transformation library. Use when transforming JSON with reusable jq filters, adding a new transform with its schema and tests, or validating JSON against transform schemas.
---

<objective>
Own reusable, tested jq transforms. Each transform is a directory under `transforms/` containing `transform.jq`, `schema.json`, `test.sh`, and `test-input-*.json` fixtures.
</objective>

<quick_start>
1. Pick or create a transform directory under `transforms/`.
2. Write `transform.jq` and its `schema.json` contract.
3. Add `test-input-*.json` fixtures covering falsy edge cases and run `test.sh`.
</quick_start>

<routing>

| intent | endpoint |
| --- | --- |
| Apply or add a transform | `transforms/<name>/` |
| Per-transform test convention | `transforms/<name>/test.sh` with 8-10 inputs, falsy coverage |
| Bats suites for this plugin | `tests/skogai-jq/` (skogai-tests plugin) |

</routing>

<success_criteria>

- Each transform ships with schema, test script, and fixtures.
- TODO: placeholder — the real transform library migrates here from `todo/skills/skogai-jq/`.

</success_criteria>
