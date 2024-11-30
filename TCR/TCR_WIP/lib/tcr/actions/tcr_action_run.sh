#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/config_file.sh"

TCR_ACTION_RUN='run'

TCR_ERROR_TCR_RUN_CFG_MISSING=$(error_build 20 "No configuration file found")

TCR_ACTION_RUN_PHASE_BUILD='Building'
TCR_ACTION_RUN_PHASE_TEST='Testing'
TCR_ACTION_RUN_PHASE_COMMIT='Committing'
TCR_ACTION_RUN_PHASE_REVERT='Reverting'

TCR_ACTION_RUN_CFG_PATH=''

tcr_action_run() {

    TCR_ACTION_RUN_CFG_PATH=$(config_file_find_first_in_dir "$TCR_WORK_DIRECTORY")
    if is_unset "$TCR_ACTION_RUN_CFG_PATH"; then
        error_raise "$TCR_ERROR_TCR_RUN_CFG_MISSING"
        return
    fi

    source "$TCR_ACTION_RUN_CFG_PATH"

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

    if is_set "$phase"; then
        print_status "$phase changes"
    fi
    run_command "$command"
}

# TODO: move to condition_tests.sh
is_success() {
    [ "$1" -eq 0 ]
}

run_command() {
    eval "*@"
}