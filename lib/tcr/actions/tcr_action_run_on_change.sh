#!/bin/bash

source "$TCR_HOME/lib/tcr/actions/tcr_action_run.sh"

TCR_ACTION_RUN_ON_CHANGE='run_on_change'

TCR_CHECK_REPO_CHANGE_CMD='git --no-pager diff HEAD --name-status'

tcr_action_run_on_change() {
    if tcr_action_run_on_change_has_changes; then
        tcr_action_run
    fi
}

tcr_action_run_on_change_has_changes() {
    is_set "$(tcr_action_run_on_change_current_changes)"
}

tcr_action_run_on_change_current_changes() {
    command_run "$TCR_CHECK_REPO_CHANGE_CMD"
}