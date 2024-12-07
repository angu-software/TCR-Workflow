#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/lock_file.sh"

source "$TCR_HOME/lib/tcr/actions/tcr_action_watch.sh"

TCR_ACTION_DISABLE='stop'

tcr_action_disable() {
    if tcr_action_watch_is_running; then
        tcr_action_watch_stop
    fi

    session_name="$(tcr_session_name)"

    lock_file_remove

    if is_set "$session_name"; then
        print_status "session '$session_name' stopped"
    else
        print_status 'session stopped'
    fi
}