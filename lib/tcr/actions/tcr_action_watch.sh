#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/actions/tcr_action_run_on_change.sh"
source "$TCR_HOME/lib/tcr/watch_directory.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"


TCR_ACTION_WATCH='watch'

TCR_ACTION_WATCH_LOOP_PROCESS_ID=''

tcr_action_watch() {
    if ! tcr_is_enabled; then
        error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(latest_error_code)"
    fi

    if is_containing "$*" "--stop"; then
        tcr_action_watch_stop
    else 
        tcr_action_watch_start
    fi
}

tcr_action_watch_is_running() {
    watch_directory_loop_is_running
}

tcr_action_watch_start() {
    print_status 'Watching for changes'

    watch_directory_loop_start tcr_action_run_on_change &
    TCR_ACTION_WATCH_LOOP_PROCESS_ID=$!
}

tcr_action_watch_stop() {
    watch_directory_loop_stop
    print_status "Stopped watching for changes"
}