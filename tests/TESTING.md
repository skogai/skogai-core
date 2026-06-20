# Testing Strategy

SkogAI testing is layered so fast local checks and large real-world validation reinforce each other without making every edit expensive.

## 1. Generated Transform Self-Tests

Each jq transform owns its schema, implementation, fixtures, and generated test cases under `plugins/skogai-jq/transforms/<name>/`. The library is expected to contain many transforms and thousands of generated cases. These tests establish operation-level behavior, especially path handling, types, and falsy values.

Generated coverage is a product of the transform contract. Regenerate it through the owning tooling; do not patch generated output to conceal a defect.

## 2. Bats Runtime Contracts

`tests/skogai-jq/` verifies the shared shell runtime: stdin capture, field defaults, JSONL logging, context responses, decisions, and realistic hook composition. These tests protect the boundary between shell and jq rather than retesting every transform.

## 3. Hook Integration Tests

`tests/skogai-hooks/` executes the event-specific entrypoints wired in `plugins/skogai-hooks/hooks/hooks.json`. Tests should use representative Claude Code payloads and assert event behavior: routing, selected context, guardrails, semantic logs, or preserved response data.

## 4. Real-History Corpus Validation

The full Claude Code JSONL history corpus is the highest-confidence compatibility pass. It catches historical schema variants, malformed records, ordering issues, large inputs, and interactions that fixtures miss. It is intentionally slower and larger than commit-time tests, so run it as a release or scheduled gate rather than on every small edit.

Record the corpus command, dataset revision, duration, and failure count with each run. Never commit private conversation data. Reduce every useful corpus failure to a sanitized fixture so the regression becomes part of the fast suite.

## Validation Cadence

| Change | Minimum validation |
| --- | --- |
| One hook | Focused hook Bats file |
| Shared jq runtime | `bats tests/skogai-jq/` plus affected hook tests |
| One transform | Its generated self-tests and fixtures |
| Generator or shared schema | All generated transform tests |
| Release or format migration | Full Bats suite, generated suite, and corpus pass |

This hierarchy is the payoff: generated cases provide breadth, Bats verifies integration contracts, and the corpus supplies production realism.
