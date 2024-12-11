#!/bin/bash

TCR_OPTION_HELP='--help'

tcr_option_help() {
    cat <<-HELP
TCR - Test && Commit || Revert

TCR is a development methodology that consists of running tests before committing code. 

If the tests pass, the code is committed. 
If the tests fail, the code is reverted.

Usage: tcr [action] [options]

Actions:

  $TCR_ACTION_INIT                   - Initialize TCR
                           Create a template configuration file
                           in the current working directory

  $TCR_ACTION_ENABLE [<session name>] - Enable TCR in the current working directory
                           Starts a TCR session.
                           Takes an optional session name as argument.

  $TCR_ACTION_STOP                   - Disable TCR
                           Ends a TCR session

  $TCR_ACTION_RUN                    - Run tests and commit or revert code 
                           based on the results

  $TCR_ACTION_STATUS                 - Show TCR status

Options:

  $TCR_OPTION_HELP     - Shows this help

  $TCR_OPTION_VERSION  - Shows the version

HELP
}