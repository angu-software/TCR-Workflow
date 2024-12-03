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
  init    - Initialize TCR
            Create a template configuration file
            in the current working directory

  enable  - Enable TCR in the current working directory
            Starts a TCR session

  disable - Disable TCR
            Ends a TCR session

  run     - Run tests and commit or revert code 
            based on the results

  status  - Show TCR status
HELP
}