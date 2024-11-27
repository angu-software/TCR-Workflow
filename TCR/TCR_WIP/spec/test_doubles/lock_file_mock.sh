#!/bin/bash

touch() {
    TCR_TEST_LOCK_FILE_PATH="$1"
}

rm() {
    TCR_TEST_LOCK_FILE_DELETE_CMD="_rm_ $1 $2"
}

is_lock_file_existing() {
    [ -n "$TCR_TEST_LOCK_FILE_PATH" ]
}

file_set_content() {
    TCR_TEST_LOCK_FILE_CONTENT="$1"
    TCR_TEST_LOCK_FILE_CONTENT_WRITE_PATH="$2"
}

setup_lock_file_mock() {
    teardown_lock_file_mock
}

teardown_lock_file_mock() {
    unset TCR_TEST_LOCK_FILE_PATH
    unset TCR_TEST_LOCK_FILE_DELETE_CMD
    unset TCR_TEST_LOCK_FILE_CONTENT
    unset TCR_TEST_LOCK_FILE_CONTENT_WRITE_PATH
}