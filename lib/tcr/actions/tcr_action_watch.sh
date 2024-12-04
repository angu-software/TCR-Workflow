#!/bin/bash

source './lib/tcr/error_consts.sh'

TCR_ACTION_WATCH='watch'

tcr_action_watch() {
    if ! tcr_is_enabled; then
        error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")" # TODO: use $? once error_raise returns the error code
    fi
}
