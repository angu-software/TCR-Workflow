#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/watch_directory.sh"
source "$TCR_HOME/lib/tcr/error_consts.sh"

TCR_ACTION_WATCH='watch'

TCR_ACTION_WATCH_LOOP_PROCESS_ID=''

tcr_action_watch() {
    if ! tcr_is_enabled; then
        error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")" # TODO: use $? once error_raise returns the error code
    fi

    watch_directory_loop_start &
    TCR_ACTION_WATCH_LOOP_PROCESS_ID=$!
}