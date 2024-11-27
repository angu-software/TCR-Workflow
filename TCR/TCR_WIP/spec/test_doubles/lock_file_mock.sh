#!/bin/bash

touch() {
    TCR_TEST_FILE_CREATE_PATH="$1"
}

rm() {
    TCR_TEST_FILE_DELETE_CMD="_rm_ $1 $2"
}

file_is_existing() {
    [ -n "$TCR_TEST_FILE_CREATE_PATH" ]
}

file_set_content() {
    TCR_TEST_FILE_SET_CONTENT="$1"
    TCR_TEST_FILE_SET_CONTENT_PATH="$2"
}

setup_file_mock() {
    teardown_file_mock
}

teardown_file_mock() {
    unset TCR_TEST_FILE_CREATE_PATH
    unset TCR_TEST_FILE_DELETE_CMD
    unset TCR_TEST_FILE_SET_CONTENT
    unset TCR_TEST_FILE_SET_CONTENT_PATH
}