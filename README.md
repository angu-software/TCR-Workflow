# TCR: Test Commit || Revert

<!-- Status Badges -->
[![Development Tests](https://github.com/angu-software/TCR-Workflow/actions/workflows/DevelopmentTests.yml/badge.svg)](https://github.com/angu-software/TCR-Workflow/actions/workflows/DevelopmentTests.yml)

Software development workflow for devs who love to challenge there own coding skills.

## Installation

Clone the repo or download one of the release artifacts and store it at a location of your choice on your machine.

To invoke TCR specify the path to the `tcr` executable from your working directory.

```text
~/My_Repos/Cool_Project &> ~/tools/TCR-Workflow/tcr init
```

## Quick start

### Preparing TCR

Create a configuration file

Run `tcr init` at the root of your git repositories root directory to let TCR generate a template configuration file

```text
$> tcr init
[TCR] Generating template configuration tcr.tcrcfg
```

Next, specify the commands for building and testing your code changes for your repository.

> Note: TCR_BUILD_CMD is optional and can be omitted if not needed

A config file to run TCR on a swift package may look like the following:

```shell
# ./tcr.tcrcfg

# TCR Configuration File
# TCR version: 0.1.0

# Build command
TCR_BUILD_CMD='swift build'

# Test command
TCR_TEST_CMD='swift test'

# Commit command
TCR_COMMIT_CMD='git add . && git commit -m "[TCR] Changes working"'

# Revert command
TCR_REVERT_CMD='git checkout --'
```

### Enable TCR workflow

To start a TCR session in our repository run:

```text
$> tcr enable
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
$> tcr disable
```

## Acknowledgements

THX to [@Kent Beck] who lit my spark on the TCR workflow at the [goto; CP 24] in a short chat! Since then I could not stop thinking about TCR which eventually led to the creation of this repository.

THX to the team creating  which created the [tcr-workshop repo], which inspired this project.

---

[@Kent Beck]: https://github.com/KentBeck
[goto; CP 24]: https://gotocph.com/2024
[tcr-workshop repo]: https://github.com/islomar/tcr-workshop
