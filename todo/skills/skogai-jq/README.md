# skogai-jq moved

The canonical, reusable skill is maintained at
[skogai/skogai-jq](https://github.com/skogai/skogai-jq).

Clone that repository as `skogai-jq` in your harness's skill directory, or
symlink its whole checkout there. Keep transforms, schemas, references, and
`SKILL.md` together. See its README for prerequisites and installation details.

This directory was migration material, not an active skill in this repository's
plugin manifest. Its 1,083 files were compared against the standalone source:
1,082 were byte-identical; the only difference was an `array-map` test's decimal
format expectation. The standalone expectation passed with jq 1.8.2 and was
retained. The standalone repository also contained 22 additional files.

Do not reintroduce a vendored copy here. Contribute transform changes upstream.
The hook-oriented `scripts/skogai-jq.sh` utility and its tests are separate from
this transform skill and remain in this repository.
