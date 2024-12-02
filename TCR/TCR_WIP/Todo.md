# Todo

## In progress

## Open

[ ] Move tcr to its own workspace/git repo
  [ ] create README.md with expales
[ ] TCR raises an error if no parameters are specified
[ ] TCR status action. Shows if tcr is enabled or disabled
[ ] TCR commands help

[ ] More documentation on the commands specified on the config template
  [ ] Build command is options, in case nothing needs to be build (comment by default?)
[ ] Watch content of directly for changes to trigger tcr
[ ] TCR raises an error if the working dir is not a git repo
[ ] Path to a config file can be specified when tcr run is executed
[ ] Optional config name can be passed as argument when creating a template cfg
[ ] TCR plays success and failure sounds (usefull when execution is based on folder changes)
[ ] cfg Templates for TCR variants
  [ ] TCR: (build,) test, commit, stash --> TCS
  [ ] TCR: (build,) test, stage, revert unstaged --> TSU
[ ] Statistics on TCR session
  [ ] tcr runs (changes), committed (success), reverted (failed), not build
  [ ] Session starts with tcr enable and ends with tcr disable
  [ ] tcr status shows those stats when enabled

## Done

[x] TCR skips comand phase when command is not specified (VAR empty or unset)
[x] TCR tells when it skips a command phase
[x] trc init tells that is created a template file
[x] TCR runs on a config file
~~[x] TCR takes an config containing the commands to execute *.tcrcgf~~
[x] TCR offers to generate a config template
[x] TCR fails with the last occurred error code
