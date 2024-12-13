#!/bin/bash

source "$TCR_HOME/lib/tcr/tcr_foundation.sh"
source "$TCR_HOME/lib/tcr/actions/tcr_action_run.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"

TCR_ACTION_RUN_ON_CHANGE='run_on_change'

TCR_ERROR_RUN_ON_CHANGE_DETECT_CMD_MISSING="$(tcr_error_build 20 'Change detection command TCR_CHANGE_DETECTION_CMD not set in configuration file')"

tcr_action_run_on_change() {
    if ! tcr_load_config; then
        return "$(latest_error_code)"
    fi

    if is_unset "$(tcr_action_run_on_change_detect_changes_cmd)"; then
        tcr_error_raise "$TCR_ERROR_RUN_ON_CHANGE_DETECT_CMD_MISSING"
        return "$(latest_error_code)"
    fi

    if tcr_action_run_on_change_has_changes; then
        tcr_action_run_on_change_print_change_detected

        tcr_action_run_on_change_run_tcr_actions
    fi
}

tcr_action_run_on_change_print_change_detected() {
    tcr_print_event "Changes detected."

    local changes
    changes="$(tcr_action_run_on_change_current_changes)"

    tcr_print_header "Detected Changes"
    echo "$changes"
    tcr_print_separator
}

tcr_action_run_on_change_run_tcr_actions() {
    result="$(tcr_action_run)"
    print "$result"
}

tcr_action_run_on_change_has_changes() {
    is_set "$(tcr_action_run_on_change_current_changes)"
}

tcr_action_run_on_change_current_changes() {
    command_run "$(tcr_action_run_on_change_detect_changes_cmd)"
}

tcr_action_run_on_change_detect_changes_cmd() {
    echo "$TCR_CHANGE_DETECTION_CMD"
}