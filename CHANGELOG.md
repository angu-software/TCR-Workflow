# CHANGELOG

## HEAD

* Add `tcr watch` to observe file changes in a git repository and run tcr on changes
* Add an optional parameter to `tcr start [session name]` to specify a tcr session name
* Rename actions `tcr enable/disable` to `tcr start/stop`

## 0.1.0

* Readme documentation on install/unistall scripts and specifying custom path for symlink
* Install/Uninstall script, creating a symlink (account for symlink resolving TCR_HOME path)
* More documentation on the commands specified on the config template
* Build command is optional, in case nothing needs to be build (comment by default?)
* TCR commands help
* TCR version option
* Installation guide in readme for TCR
* create README.md with expamples
* TCR status action. Shows if tcr is enabled or disabled
* TCR raises an error if no parameters are specified
* Move tcr to its own workspace/git repo
* TCR skips comand phase when command is not specified (VAR * empty or unset)
* TCR tells when it skips a command phase
* trc init tells that is created a template file
* TCR runs on a config file
* TCR offers to generate a config template
* TCR fails with the last occurred error code
