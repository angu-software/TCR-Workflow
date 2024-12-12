# Worklog

## In progress

### Next up

## Open

* [ ] Forward output of tcr action to not mix error output with success output

* [ ] Beautify the output of `tcr status`

* [ ] Document the VARs which should be available in the config file

* [ ] Set a session name after tcr is already started

* [ ] structure to define a action with options
* [ ] obtain options for action from arguments
* [ ] dynamic help generation

* [ ] ensure that watch loop runs further after executed commands fail
* [ ] Add some hints to errors. What can the user do to avoid the error

* [ ] Offer action to squash tcr commit together with a new message
  * [ ] Write sessions parten commit to lock file
  * [ ] optionally specify the parent commit
  * [ ] rebase first? (case that parent commit is not existing after origin rebase)

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

* [x] add `tcr watch` to help
* [x] `tcr status` reflects that watch is running
* [x] `tcr watch --stop` to stop running observation
* [x] Make sure `tcr watch` keeps running after failed commands
* [x] `tcr watch` tells which changes are detected
* [x] tell that tcr watch has started
* [x] error_raise should still return the error code
* [x] Offer to adjust the change detection command through the config file (offers to adjust which folders to watch)
* [x] Optional partameter for TCR start to specify some label to check on focus of the session
  * [x] reflected in tcr status
  * [x] rename ON OFF to TCR <name> session stopped
  * [x] rename ON OFF to TCR <name> session started
  * [x] TCR status tells "TCR session <name> active"
  * [x] TCR status tells "TCR no session active"
* [x] Rename for tcr enable/disable -> start/stop
* [x] `tcr disable` also stops watch
* [x] add method tcr_action_watch_is_watch_running
* [x] Watch content of directory for changes to trigger tcr (consider git diff-index HEAD  --name-status -- $PATHS)
