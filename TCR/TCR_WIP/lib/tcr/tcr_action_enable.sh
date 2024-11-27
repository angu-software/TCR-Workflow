#!/bin/bash

source "$TCR_HOME/lib/lock_file.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"

TCR_ACTION_ENABLE='enable'

tcr_action_enable() {
    if lock_file_is_existing; then
        error_raise "$TCR_ERROR_TCR_ALREADY_ENABLED"
        return
    fi

    setup_lock_file
    print_status 'ON'
}

setup_lock_file() {
    lock_file_create
    lock_file_set_content "$(prepare_lock_file_content)"
}

prepare_lock_file_content() {
    local content
    content="$(cat <<-LOCK_FILE_CONTENT
TCR_HOME="$(path_expand "$TCR_HOME")"
LOCK_FILE_CONTENT
    )"

    echo "$content"
}