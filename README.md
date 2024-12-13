# TCR: Test Commit || Revert

<!-- Status Badges -->
[![Development Tests](https://github.com/angu-software/TCR-Workflow/actions/workflows/DevelopmentTests.yml/badge.svg)](https://github.com/angu-software/TCR-Workflow/actions/workflows/DevelopmentTests.yml)

Software development workflow for devs who love to challenge there own coding skills.

## Installation

Clone the repo or download one of the release artifacts and store it at a location of your choice on your machine.

From that folder run

```text
$> install_tcr.sh
```

It will create a symlink to the tcr executable so you do not need to specify the full path of the tcr executable every time you want to use the tool.

> Note: You can specify the path where the tcr symlink is create by adapting the `tcr.env`

## Quick start

### Preparing TCR

Create a configuration file

Run `tcr init` at the root of your git repositories root directory to let TCR generate a template configuration file

```text
$> tcr init
[09:10:11] Generating template configuration tcr.tcrcfg...
[09:10:11] Generating template completed.
```

Next, specify the commands for building and testing your code changes for your repository.

> Note: TCR_BUILD_CMD is optional and can be omitted if not needed

A config file to run TCR on a swift package may look like the following:

```shell
# ./tcr.tcrcfg

# TCR Configuration File
# TCR version: 1.0.0

# -- Build command (Optional) --
# Command to build the project before running tests.
# TCR_BUILD_CMD=''

# -- Test command --
# Command to run the tests.
TCR_TEST_CMD='swift test'

# -- Commit command --
# Command to commit the changes if tests pass.
TCR_COMMIT_CMD='git add . && git commit -m "[TCR] Changes working"'

# -- Revert command --
# Command to revert the changes if tests fail.
TCR_REVERT_CMD='git reset --hard'

# -- Detecting changes in repository -- #
# Command to detect changes in the repository when running 'tcr watch'
TCR_CHANGE_DETECTION_CMD='git --no-pager diff HEAD --name-status'

```

### Enable TCR workflow

To start a TCR session in our repository run:

```text
$> tcr start
```

### Run TCR

After making a change in a source file run:

```text
$> trc run
```

It will execute the configured build and test command.

Depending on the success or failure of the *test command* TCR will either

* commit your changes or
* revert them.

### Disable TCR workflow

To end the TCR session run:

```text
$> tcr stop
```

## Acknowledgements

THX to [@Kent Beck] who lit my spark on the TCR workflow at the [goto; CP 24] in a short chat! Since then I could not stop thinking about TCR which eventually led to the creation of this repository.

THX to the team creating  which created the [tcr-workshop repo], which inspired this project.

---

[@Kent Beck]: https://github.com/KentBeck
[goto; CP 24]: https://gotocph.com/2024
[tcr-workshop repo]: https://github.com/islomar/tcr-workshop
