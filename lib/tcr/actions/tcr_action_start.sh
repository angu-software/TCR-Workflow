#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"

TCR_ACTION_START='start'

tcr_action_start() {
    session_name="$1"

    if lock_file_is_existing; then
        tcr_error_raise "$TCR_ERROR_TCR_ALREADY_ENABLED"
        return "$(latest_error_code)"
    fi

    if is_set "$session_name"; then
        tcr_print_event "Starting TCR session '$session_name'..."
    else
        tcr_print_event 'Starting TCR session...'
    fi

    setup_lock_file "$session_name"

    if is_set "$session_name"; then
        tcr_print_event "TCR session '$session_name' started."
    else
        tcr_print_event 'TCR session started.'
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