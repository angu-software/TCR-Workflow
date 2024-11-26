#!/bin/bash

touch() {
    TRC_TEST_LOCK_FILE_PATH="$1"
}

rm() {
    TRC_TEST_LOCK_FILE_DELETE_CMD="_rm_ $1 $2"
}

is_lock_file_existing() {
    [ -n "$TRC_TEST_LOCK_FILE_PATH" ]
}

setup_lock_file_mock() {
    teardown_lock_file_mock
}

teardown_lock_file_mock() {
    unset TRC_TEST_LCK_FILE_PATH
    unset TRC_TEST_LOCK_FILE_DELETE_CMD
}