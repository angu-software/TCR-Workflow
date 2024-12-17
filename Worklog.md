# Worklog

## In progress

### Next up

## Open

* [ ] Add parameter to `tcr run` to skip commit/revert phase (useful when drafting the test)

* [ ] Forward output of tcr action to not mix error output with success output

* [ ] Document the VARs which should be available in the config file

* [ ] Set a session name after tcr is already started

* [ ] structure to define an action with options
* [ ] obtain options for action from arguments
* [ ] dynamic help generation

* [ ] Add warnings output if commands are failing
  * [ ] Add a warning if the commit command is failing
  * [ ] Add a warning if the revert command is failing
  * [ ] Add a warning if the notification command is failing
* [ ] Add some hints to errors. What can the user do to avoid the error

* [ ] Offer action to squash tcr commit together with a new message
  * [ ] Write sessions starting commit to lock file
  * [ ] optionally specify the parent commit
  * [ ] rebase first? (case that parent commit is not existing after origin rebase)
  * [ ] Specify command in config file

* [ ] Path to a config file can be specified when tcr run is executed
* [ ] Optional config name can be passed as argument when creating a template cfg

* [ ] cfg Templates for TCR variants
  * [ ] TCR: (build,) test, commit, stash --> TCS
  * [ ] TCR: (build,) test, stage, revert unstaged --> TSU

* [ ] Statistics on TCR session
  * [ ] tcr runs (changes), committed (success), reverted (failed), not build
  * [ ] Session starts with tcr enable and ends with tcr disable
  * [ ] tcr status shows those stats when enabled

## Done