#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/lock_file.sh"

source "$TCR_HOME/lib/tcr/error_consts.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"
source "$TCR_HOME/lib/tcr/actions/tcr_action_watch.sh"

TCR_ACTION_STOP='stop'

tcr_action_stop() {
    if ! tcr_is_enabled; then
        tcr_error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(latest_error_code)"
    fi

    if tcr_action_watch_is_running; then
        tcr_action_watch_stop
    fi

    session_name="$(tcr_session_name)"

    if is_set "$session_name"; then
        tcr_print_event "Stopping TCR session '$session_name'..."
    else
        tcr_print_event 'Stopping TCR session...'
    fi

    lock_file_remove

    if is_set "$session_name"; then
        tcr_print_event "TCR Session '$session_name' stopped."
    else
        tcr_print_event 'TCR session stopped.'
    fi
}