#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"

TCR_ACTION_INIT='init'

TCR_ERROR_TCR_INIT_CFG_EXISTS="$(error_build 10 'Config file already exists')"

tcr_action_init() {

    if config_file_exists_in_dir "$TCR_WORK_DIRECTORY"; then
        error_raise "$TCR_ERROR_TCR_INIT_CFG_EXISTS"
        return
    fi

    create_config_template
}

create_config_template() {
    print_status "Generating template configuration $(config_file_template_file_name)"
    config_file_create_template
}