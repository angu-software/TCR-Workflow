#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"

tcr_is_enabled() {
    lock_file_is_existing
}

tcr_session_name() {
    tcr_load_session_info
    
    echo "$TCR_SESSION_NAME"
}

tcr_load_session_info() {
    lock_file_load
}

tcr_load_config() {
    cfg_path="$(config_file_find_first_in_dir "$TCR_WORK_DIRECTORY")"
    if is_unset "$cfg_path"; then
        error_raise "$TCR_ERROR_TCR_CFG_MISSING"
        return "$(latest_error_code)"
    fi

    config_file_load "$cfg_path"

    TCR_ACTION_RUN_CFG_PATH="$cfg_path"
}

latest_error_code() {
    echo "$?"
}