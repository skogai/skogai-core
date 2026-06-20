---
description: Run the skogai bats test suites
---

Run the bats test suites in this repository.

1. Run `bats tests/**/*.bats` from the repository root.
2. If a specific plugin is named in `$ARGUMENTS`, run only its subfolder, e.g. `bats tests/skogai-hooks/`.
3. Report failures with the failing test name and assertion output.
4. For transform, generator, release, or corpus work, read `tests/TESTING.md` and run the additional owning validation layer.

This command currently owns the Bats layer. Generated transform and corpus runners remain separate because they have different cost, data, and reporting requirements.
