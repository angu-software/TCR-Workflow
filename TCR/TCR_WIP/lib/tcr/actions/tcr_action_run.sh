#!/bin/bash

TCR_ACTION_RUN='run'

tcr_action_run() {
    if execute_build_command; then
        execute_test_command
    fi
}

execute_build_command() {
    run_command "$TCR_RUN_BUILD_COMMAND"
    error_code=$?

    if [ $error_code -ne 0 ]; then
        error_raise "$(build_command_failure "$error_code")"
    fi
}

execute_test_command() {
    run_command "$TCR_RUN_TEST_COMMAND"
}

build_command_failure() {
    error_code="$1"
    error_build "$error_code" "Build failed with status $error_code"
}

run_command() {
    eval "*@"
}