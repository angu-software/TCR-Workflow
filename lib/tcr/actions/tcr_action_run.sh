#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"
source "$TCR_HOME/lib/tcr/tcr_phase.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"

TCR_ACTION_RUN='run'

TCR_ACTION_RUN_PHASE_BUILD="$TCR_BUILD_PHASE"
TCR_ACTION_RUN_PHASE_TEST="$TCR_TEST_PHASE"
TCR_ACTION_RUN_PHASE_COMMIT="$TCR_COMMIT_PHASE"
TCR_ACTION_RUN_PHASE_REVERT="$TCR_REVERT_PHASE"

TCR_NOTIFY_SUCCESS_PHASE="notify_success|Notify|Notifying about success...|Successfully notified.|Notifying failed."
TCR_NOTIFY_FAILURE_PHASE="notify_failure|Notify|Notifying about failure...|Successfully notified.|Notifying failed."

tcr_action_run() {
    if ! tcr_is_enabled; then
        tcr_error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(latest_error_code)"
    fi

    if ! tcr_load_config; then
        return "$(latest_error_code)"
    fi

    tcr_print_event "Starting TCR run..."

    execute_phase "$TCR_ACTION_RUN_PHASE_BUILD"
    phase_error_code=$?

    if is_success "$phase_error_code"; then        
        execute_phase "$TCR_ACTION_RUN_PHASE_TEST"
        phase_error_code=$?

        if is_success "$phase_error_code"; then
            execute_phase "$TCR_ACTION_RUN_PHASE_COMMIT"
        else            
            execute_phase "$TCR_ACTION_RUN_PHASE_REVERT"
        fi
    fi

    if is_success "$phase_error_code"; then
        execute_phase "$TCR_NOTIFY_SUCCESS_PHASE"
    else
        execute_phase "$TCR_NOTIFY_FAILURE_PHASE"
    fi

    tcr_print_event "TCR run completed."
}

execute_phase() {
    phase="$1"

    execute_phase_command "$phase" "$(command_for_phase)"
}

command_for_phase() {
    case "$phase" in
        "$TCR_ACTION_RUN_PHASE_BUILD")
            echo "$TCR_BUILD_CMD"
            ;;
        "$TCR_ACTION_RUN_PHASE_TEST")
            echo "$TCR_TEST_CMD"
            ;;
        "$TCR_ACTION_RUN_PHASE_REVERT")
            echo "$TCR_REVERT_CMD"
            ;;
        "$TCR_ACTION_RUN_PHASE_COMMIT")
            echo "$TCR_COMMIT_CMD"
            ;;
        "$TCR_NOTIFY_SUCCESS_PHASE")
            echo "$TCR_NOTIFICATION_SUCCESS_CMD"
            ;;
        "$TCR_NOTIFY_FAILURE_PHASE")
            echo "$TCR_NOTIFICATION_FAILURE_CMD"
            ;;
    esac
}

execute_phase_command() {
    phase="$1"
    command="$2"

    if is_unset "$command"; then
        phase_name="$(tcr_phase_get_name "$phase")"
        tcr_print_event "Skipping $phase_name phase, no command specified."
        return "$(last_command_status)"
    fi

    tcr_phase_exec "$phase" "$command"
}