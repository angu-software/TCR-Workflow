#!/bin/bash

TCR_ACTION_RUN='run'

tcr_action_run() {

    subject='Building'
    execute_build_command
    error_code=$?

    if [ $error_code -eq 0 ]; then
        subject='Testing'
        execute_test_command
        error_code_testing=$?

        if [ "$error_code_testing" -ne 0 ]; then
            execute_revert_command
            error_code_revert=$?
            if [ "$error_code_revert" -ne 0 ]; then
                subject='Reverting'
                error_code="$error_code_revert"
            else
                error_code="$error_code_testing"
            fi
        else
            subject='Committing'
            execute_commit_command
            error_code=$?
        fi
    fi

    handle_error "$error_code" "$subject"
}

handle_error() {
    error_code="$1"
    subject="$2"

    if [ "$error_code" -ne 0 ]; then
        error_raise "$(make_run_command_error "$error_code" "$subject")"
    fi
}

execute_build_command() {
    run_command "$TCR_RUN_BUILD_COMMAND"
}

execute_test_command() {
    run_command "$TCR_RUN_TEST_COMMAND"
}

execute_commit_command() {
    print_status 'Committing changes'
    run_command "$TCR_RUN_COMMIT_COMMAND"
}

execute_revert_command() {
    print_status 'Reverting changes'
    run_command "$TCR_RUN_REVERT_COMMAND"
}

make_run_command_error() {
    error_code="$1"
    subject="$2"
    error_build "$error_code" "$subject failed with status $error_code"
}

run_command() {
    eval "*@"
}