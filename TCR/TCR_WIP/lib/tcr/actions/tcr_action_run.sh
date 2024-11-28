#!/bin/bash

TCR_ACTION_RUN='run'

tcr_action_run() {

    execution_phase='Building'
    execute_phase "$execution_phase"
    phase_error_code=$?

    if is_success "$phase_error_code"; then
        execution_phase='Testing'
        execute_phase "$execution_phase"
        phase_error_code=$?

        if is_success "$phase_error_code"; then
            execution_phase='Committing'
            execute_phase "$execution_phase"
            phase_error_code=$?
        else
            error_code_testing="$phase_error_code"

            execution_phase='Reverting'
            execute_phase "$execution_phase"
            phase_error_code=$?

            if is_success "$phase_error_code"; then
                execution_phase='Testing'
                phase_error_code="$error_code_testing"
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
        'Building')
            echo "$TCR_RUN_BUILD_COMMAND"
            ;;
        'Testing')
            echo "$TCR_RUN_TEST_COMMAND"
            ;;
        'Reverting')
            echo "$TCR_RUN_REVERT_COMMAND"
            ;;
        'Committing')
            echo "$TCR_RUN_COMMIT_COMMAND"
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

    if [ -n "$phase" ]; then
        print_status "$phase changes"
    fi
    run_command "$command"
}

is_success() {
    [ "$1" -eq 0 ]
}

run_command() {
    eval "*@"
}