#!/bin/bash

TCR_EXIT='exit_mock'

exit_mock() {
    TCR_TEST_EXIT_STATUS="$1"
}

setup_exit_mock() {
    teardown_exit_mock
}

teardown_exit_mock() {
    unset TCR_TEST_EXIT_STATUS
}