#!/bin/bash

source "./lib/condition_tests.sh"

source "./spec/test_doubles/rm_stub.sh"

touch() {
    TCR_TEST_FILE_CREATE_PATH="$1"
}

file_is_existing() {
    is_set "$TCR_TEST_FILE_CREATE_PATH"
}

file_set_content() {
    TCR_TEST_FILE_SET_CONTENT="$1"
    TCR_TEST_FILE_SET_CONTENT_PATH="$2"
}

setup_file_mock() {
    teardown_file_mock
}

teardown_file_mock() {
    test_stub_rm_reset

    unset TCR_TEST_FILE_CREATE_PATH
    unset FILE_SYSTEM_STUB_RM
    unset TCR_TEST_FILE_SET_CONTENT
    unset TCR_TEST_FILE_SET_CONTENT_PATH
}