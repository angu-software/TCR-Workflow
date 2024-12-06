#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/lock_file.sh"

source "$TCR_HOME/lib/tcr/actions/tcr_action_watch.sh"

TCR_ACTION_DISABLE='stop'

tcr_action_disable() {
    lock_file_remove

    if tcr_action_watch_is_running; then
        tcr_action_watch_stop
    fi

    print_status 'OFF'
}