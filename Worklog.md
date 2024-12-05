# Worklog

## In progress

## Open

* [ ] `tcr disable` also stops watch
* [ ] `tcr watch --stop` to stop running observation
* [ ] add `tcr watch` to help
* [ ] Offer to adjust the change detection command through the config file (offers to adjust which folders to watch)
* [ ] tell that watch has started
* [ ] `tcr status` reflects that watch is running

* [ ] structure to define a action with options
* [ ] obtain options for action from arguments

* [ ] ensure that watch loop runs further after executed commands fail
* [ ] error_raise should still return the error code
* [ ] Add some hints to errors. What can the user do to avoid the error
* [ ] Offer action to squash tcr commit together with a new message
* [ ] Call tcr run every 2s (configurable)
* [ ] Path to a config file can be specified when tcr run is executed
* [ ] Optional config name can be passed as argument when creating a template cfg
* [ ] TCR plays success and failure sounds (usefull when execution is based on folder changes)
* [ ] cfg Templates for TCR variants
  * [ ] TCR: (build,) test, commit, stash --> TCS
  * [ ] TCR: (build,) test, stage, revert unstaged --> TSU
* [ ] Statistics on TCR session
  * [ ] tcr runs (changes), committed (success), reverted (failed), not build
  * [ ] Session starts with tcr enable and ends with tcr disable
  * [ ] tcr status shows those stats when enabled

## Done

* [x] Watch content of directory for changes to trigger tcr (consider git diff-index HEAD  --name-status -- $PATHS)
