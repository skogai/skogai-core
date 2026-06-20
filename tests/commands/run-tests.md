---
description: Run the skogai bats test suites
---

Run the bats test suites in this repository.

1. Run `bats tests/**/*.bats` from the repository root.
2. If a specific plugin is named in `$ARGUMENTS`, run only its subfolder, e.g. `bats tests/skogai-hooks/`.
3. Report failures with the failing test name and assertion output.

TODO: placeholder — extend with per-transform `test.sh` discovery once the jq transform library migrates in.
