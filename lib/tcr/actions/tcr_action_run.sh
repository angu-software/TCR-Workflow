#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"

TCR_ACTION_RUN='run'

TCR_ACTION_RUN_PHASE_BUILD='Building'
TCR_ACTION_RUN_PHASE_TEST='Testing'
TCR_ACTION_RUN_PHASE_COMMIT='Committing'
TCR_ACTION_RUN_PHASE_REVERT='Reverting'

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

    handle_error "$phase_error_code" "$execution_phase"
}

handle_error() {
    error_code="$1"
    execution_phase="$2"

    if ! is_success "$error_code"; then
        error_raise "$(make_run_command_error "$error_code" "$execution_phase")"
        return "$error_code"
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

make_run_command_error() {
    error_code="$1"
    execution_phase="$2"
    error_build "$error_code" "$execution_phase failed with status $error_code"
}

execute_phase_command() {
    phase="$1"
    command="$2"

    if is_unset "$command"; then
        print_status "Skipping $phase phase"
        return "$(last_command_status)"
    fi

    if is_set "$phase"; then
        print_status "$phase changes"
    fi

    command_run "$command"
}