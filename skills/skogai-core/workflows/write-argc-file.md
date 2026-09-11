<workflow>

<objective>
Create a bash script whose CLI is defined by argc (https://github.com/sigoden/argc) comment annotations.
</objective>

<steps>

1. Start the file with `#!/usr/bin/env bash` and `set -euo pipefail`.
2. Write one `# @describe <text>` comment above the first `@cmd` function to describe the whole CLI. Add `# @version` or `# @author` above it only if the CLI needs them.
3. Write one function per subcommand. Directly above each function, add `# @cmd <description>` — the function name becomes the subcommand name (underscores become dashes). Add `# @alias <name>` only when a short alias is needed.
4. Declare each subcommand's inputs as comment lines directly above its function, in the order they should appear in `--help`:
   - `# @option --name <VAL> <description>` for a value-taking option.
   - `# @flag -f --force <description>` for a boolean flag.
   - `# @arg name <description>` for a positional argument.
   Add modifiers only when the CLI needs them: `!` required, `*` zero-or-more, `+` one-or-more, `[a|b]` choices.
5. Inside each function, read parsed values as `$argc_<name>` (dashes in option/arg names become underscores). Do not re-parse `$@` by hand.
6. End the file with `eval "$(argc --argc-eval "$0" "$@")"` so argc parses the comments above and dispatches to the matching function. Nothing below this line runs directly.
7. Make the file executable with `chmod +x`. Name it `argcfile.sh` only if it should be auto-discovered by a bare `argc <subcommand>` run in that directory; otherwise name it for what it does.

</steps>

<validation>

- `./<file> --help` lists every subcommand with its description.
- `./<file> <subcommand> --help` shows that subcommand's options, flags, and args with correct requiredness and choices.
- Running a subcommand with valid input produces the expected output with no unset-variable errors.
- `shellcheck <file>` passes on the bash body outside the argc comments.

</validation>

</workflow>
