#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"

TCR_ACTION_INIT='init'

TCR_ERROR_TCR_INIT_CFG_EXISTS="$(tcr_error_build 10 'Config file already exists!')"

tcr_action_init() {

    if config_file_exists_in_dir "$TCR_WORK_DIRECTORY"; then
        tcr_error_raise "$TCR_ERROR_TCR_INIT_CFG_EXISTS"
        return "$(latest_error_code)"
    fi

    create_config_template
}

create_config_template() {
    tcr_print_event "Generating template configuration $(config_file_template_file_name)..."
    config_file_create_template
    tcr_print_event "Generating template completed."
}