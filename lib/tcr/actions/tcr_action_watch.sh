#!/bin/bash

source './lib/foundation.sh'
source './lib/tcr/error_consts.sh'

TCR_ACTION_WATCH='watch'

TCR_ACTION_LOCK_FILE_NAME='tcr_watch.lock'
TCR_ACTION_LOCK_FILE_PATH="$TCR_WORK_DIRECTORY/$TCR_ACTION_LOCK_FILE_NAME"

tcr_action_watch() {
    if ! tcr_is_enabled; then
        error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")" # TODO: use $? once error_raise returns the error code
    fi

    file_create "$TCR_ACTION_LOCK_FILE_PATH"
}
