# Testing Guidelines

This directory is the `skogai-tests` plugin and the repository-level home for cross-plugin integration tests. Read [TESTING.md](TESTING.md) before adding or migrating coverage.

## Scope and Ownership

- Put Bats integration tests in the subdirectory for the plugin under test: `skogai-hooks/` or `skogai-jq/`.
- Keep transform-owned fixtures and generated self-tests beside each transform under `plugins/skogai-jq/transforms/<name>/`.
- Use `test-helper.bash` for shared Bats assertions and asynchronous file waits.
- Treat `todo/tests/` as migration input, not the canonical suite.

## Required Test Shape

Exercise behavior through public scripts. For hooks, send realistic event JSON through stdin, then use `jq` to assert exact selected fields, content, routing, or output shape. Do not add tests that only prove Bash exits zero, JSON parses, or a field exists.

When a corpus record exposes a regression, reduce it to the smallest representative fixture and keep that fixture permanently with the owning test.

## Commands

Run from the repository root:

```bash
bats tests/**/*.bats
bats tests/skogai-hooks/
bats tests/skogai-jq/
shellcheck plugins/skogai-hooks/hooks/scripts/*.sh plugins/skogai-jq/scripts/*.sh
```

Run focused tests while iterating, all Bats tests before commit, generated transform tests before merging transform changes, and the real-history corpus pass for release or scheduled regression validation.

## Change Rules

- Do not hand-edit generated expectations when the generator owns them; fix the transform, schema, fixture, or generator.
- Preserve falsy-value coverage: `null`, `false`, `0`, `""`, `[]`, and `{}`.
- Report the exact commands run and distinguish focused, generated, and corpus results.
