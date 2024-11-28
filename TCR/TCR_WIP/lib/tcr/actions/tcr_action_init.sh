#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"

TCR_ACTION_INIT='init'

TCR_ERROR_TCR_INIT_CFG_EXISTS="$(error_build 10 'Config file already exists')"

# Create template config
# Template contains default reset and commit commands
# Optional config name can be passed as argument

tcr_action_init() {

    if config_file_exists_in_dir "$TCR_WORK_DIRECTORY"; then
        error_raise "$TCR_ERROR_TCR_INIT_CFG_EXISTS"
        return
    fi

    config_file_create
}