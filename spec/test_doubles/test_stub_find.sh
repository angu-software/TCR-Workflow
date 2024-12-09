#!/bin/bash

source "./spec/test_doubles/test_stub.sh"

TCR_FIND_CMD='test_stub_find'
TEST_SPY_FIND_FILE_PATH="$TCR_TEST_STUB_FILE_ROOT_PATH/test_stub_find.$TCR_TEST_STUB_FILE_EXTENSION"
TEST_STUB_FIND_RESULT_FILE_PATH='./spec/fixtures/config_fixture.tcrcfg'
test_stub_find() {
    echo "find $*" > "$TEST_SPY_FIND_FILE_PATH"

    echo "$TEST_STUB_FIND_RESULT_FILE_PATH"
}

test_stub_find_call_log() {
    call_log="$(<"$TEST_SPY_FIND_FILE_PATH")"

    echo "$call_log"
}