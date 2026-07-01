# Repository Guidelines

## Project Structure & Module Organization

This repository is a Claude Code plugin marketplace. `.claude-plugin/marketplace.json` is the canonical catalog for the published plugins.

- `skills/skogai-core/` contains the routing skill, JSON schemas, workflows, references, templates, and validation scripts.
- `plugins/skogai-hooks/` contains lifecycle hook configuration and shell scripts.
- `plugins/skogai-jq/` contains the jq plugin skill; transforms belong under `transforms/<name>/`.
- `tests/` is the `skogai-tests` plugin and owns Bats suites, grouped by plugin (`tests/skogai-hooks/`, `tests/skogai-jq/`).
- `agents/` contains reusable agent definitions. Treat `todo/` and `todo2/` as migration material, not active plugin surfaces.

Read the nearest nested guidance when present, especially `tests/AGENTS.md` for test scope and `tests/TESTING.md` for validation strategy.

## Build, Test, and Development Commands

There is no compilation step. Run commands from the repository root:

- `skills/skogai-core/scripts/validate-schema.sh` validates typed Markdown and list files against the core schemas; do not commit with failures.
- `bats tests/**/*.bats` runs all migrated plugin tests.
- `bats tests/skogai-hooks/` runs one plugin suite while iterating.
- `shellcheck plugins/skogai-hooks/hooks/scripts/*.sh` checks hook scripts when ShellCheck is installed.

The schema validator uses `uv` to resolve its Python dependencies.

## Coding Style & Naming Conventions

Use two-space indentation for JSON and YAML, four spaces for Python, and idiomatic Bash with `set -euo pipefail`. Keep routing files concise: ordered procedures belong in `workflows/`, durable facts in `references/`, reusable shapes in `templates/`, and repeatable actions in `scripts/`. Use lowercase kebab-case for skill and transform directories. New structured Markdown should declare a supported `type` and use semantic XML sections consistent with `skills/skogai-core/schemas/`.

## Testing Guidelines

Write Bats files as `*.bats` in the matching plugin subdirectory. Assert content selection and output shape, using `jq` to extract fields; avoid tests that only prove an exit code is zero or JSON is valid. A jq transform should keep `transform.jq`, `schema.json`, `test.sh`, and representative `test-input-*.json` together.

## Commit & Pull Request Guidelines

Recent history favors short, imperative subjects such as `Add ...`, `Remove ...`, or `Update ...`. Keep commits focused on one plugin or framework concern. Pull requests should explain behavior and migration impact, identify affected plugin entries, link relevant issues, and report the exact validation and test commands run. Include screenshots only for user-visible output.
