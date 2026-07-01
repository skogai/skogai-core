---
type: skill
name: skogai-jq
description: This skill should be used when the user asks to "parse hook JSON input", "build a hook response", "add a jq transform", "write a transform schema", or needs shared jq/JSON utilities for hook I/O or schema-driven transformations.
---

<objective>
Own tested JSON utilities for hooks and reusable jq transforms. The hook runtime lives at `scripts/skogai-jq.sh`; each transform is a directory under `transforms/` containing `transform.jq`, `schema.json`, `test.sh`, and `test-input-*.json` fixtures.
</objective>

<quick_start>
1. For hook JSON I/O, source `scripts/skogai-jq.sh` and use its field, logging, context, or decision helpers.
2. For transformations, pick or create a directory under `transforms/` and define `transform.jq` with its `schema.json` contract.
3. Add fixtures or Bats coverage for the changed behavior and run the relevant test suite.
</quick_start>

<routing>

| intent | endpoint |
| --- | --- |
| Parse hook input or build hook output | `scripts/skogai-jq.sh` |
| Apply or add a transform | `transforms/<name>/` |
| Per-transform test convention | `transforms/<name>/test.sh` with 8-10 inputs, falsy coverage |
| Bats suites for this plugin | `tests/skogai-jq/` (skogai-tests plugin) |

</routing>

<success_criteria>

- Each transform ships with schema, test script, and fixtures.
- The shared hook runtime passes `tests/skogai-jq/skogai-jq.bats`.
- Remaining transforms migrate here from `todo/skills/skogai-jq/`.

</success_criteria>
