# tests/

Bats test suites for skogai plugins, one subfolder per plugin under test. Run with `bats tests/**/*.bats`.

## What tests are for

Tests catch regressions — a hook that stops injecting context, a transform that stops filtering, a separator that disappears. They are not for verifying that bash works.

## What not to test

When a hook or transform declares its IO contract (schema, typed sentinels), the type safety lives in the implementation. Do not re-verify it:

- Hook exits 0
- Output is valid JSON
- A field merely exists

## What to test

Content selection, filtering, and output shape — things that can silently regress.

## Assertion style

Extract with jq, then assert specific content:

```bash
ctx=$(echo "$output" | jq -r '.hookSpecificOutput.additionalContext')
```

Assert exact strings that should be there, not just "non-empty".
