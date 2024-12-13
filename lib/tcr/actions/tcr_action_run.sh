#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"
source "$TCR_HOME/lib/tcr/tcr_phase.sh"

# TODO: remove this dependency
source "$TCR_HOME/lib/tcr/tcr_print.sh"

TCR_ACTION_RUN='run'

TCR_ACTION_RUN_PHASE_BUILD="$TCR_BUILD_PHASE"
TCR_ACTION_RUN_PHASE_TEST="$TCR_TEST_PHASE"
TCR_ACTION_RUN_PHASE_COMMIT="$TCR_COMMIT_PHASE"
TCR_ACTION_RUN_PHASE_REVERT="$TCR_REVERT_PHASE"

tcr_action_run() {
    if ! tcr_is_enabled; then
        error_raise "$TCR_ERROR_TCR_NOT_ENABLED"
        return "$(latest_error_code)"
    fi

    if ! tcr_load_config; then
        return "$(latest_error_code)"
    fi

    execution_phase="$TCR_ACTION_RUN_PHASE_BUILD"
    execute_phase "$execution_phase"
    phase_error_code=$?

    if is_success "$phase_error_code"; then
        prev_phase="$execution_phase"
        prev_error_code="$phase_error_code"
        
        execution_phase="$TCR_ACTION_RUN_PHASE_TEST"
        execute_phase "$execution_phase"
        phase_error_code=$?

        if is_success "$phase_error_code"; then
            prev_phase="$execution_phase"
            prev_error_code="$phase_error_code"

            execution_phase="$TCR_ACTION_RUN_PHASE_COMMIT"
            execute_phase "$execution_phase"
            phase_error_code=$?
        else            
            prev_phase="$execution_phase"
            prev_error_code="$phase_error_code"

            execution_phase="$TCR_ACTION_RUN_PHASE_REVERT"
            execute_phase "$execution_phase"
            phase_error_code=$?

            if is_success "$phase_error_code"; then
                execution_phase="$prev_phase"
                phase_error_code="$prev_error_code"
            fi
        fi
    fi
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