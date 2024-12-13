# Worklog

## In progress

### Next up

## Open

* [ ] Add parameter to `tcr run` to skip commit/revert phase (useful when drafting the test)

* [ ] Forward output of tcr action to not mix error output with success output

* [ ] Beautify the output of `tcr status`

* [ ] Document the VARs which should be available in the config file

* [ ] Set a session name after tcr is already started

* [ ] structure to define a action with options
* [ ] obtain options for action from arguments
* [ ] dynamic help generation

* [ ] Add some hints to errors. What can the user do to avoid the error

* [ ] Offer action to squash tcr commit together with a new message
  * [ ] Write sessions starting commit to lock file
  * [ ] optionally specify the parent commit
  * [ ] rebase first? (case that parent commit is not existing after origin rebase)
  * [ ] Specify command in config file

* [ ] Path to a config file can be specified when tcr run is executed
* [ ] Optional config name can be passed as argument when creating a template cfg

* [ ] TCR plays success and failure sounds (usefull when execution is based on folder changes) After tcr commands for failure/success

* [ ] cfg Templates for TCR variants
  * [ ] TCR: (build,) test, commit, stash --> TCS
  * [ ] TCR: (build,) test, stage, revert unstaged --> TSU

* [ ] Statistics on TCR session
  * [ ] tcr runs (changes), committed (success), reverted (failed), not build
  * [ ] Session starts with tcr enable and ends with tcr disable
  * [ ] tcr status shows those stats when enabled

## Done

* [x] phase exec tell error code of failed command in output
* [x] Structured output for tcr run