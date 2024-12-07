#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"

TCR_ACTION_ENABLE='start'

tcr_action_enable() {
    session_name="$2"

    if lock_file_is_existing; then
        error_raise "$TCR_ERROR_TCR_ALREADY_ENABLED"
        return
    fi

    setup_lock_file "$session_name"

    if is_set "$session_name"; then
        print_status "session '$session_name' started"
    else
        print_status 'session started'
    fi
}

setup_lock_file() {
    session_name="$1"

    lock_file_create
    lock_file_set_content "$(prepare_lock_file_content "$session_name")"
}

prepare_lock_file_content() {
    local session_name
    session_name="$1"

    local content
    content="$(cat <<-LOCK_FILE_CONTENT
TCR_HOME="$(path_expand "$TCR_HOME")"
TCR_SESSION_NAME="$session_name"
LOCK_FILE_CONTENT
    )"

    echo "$content"
}