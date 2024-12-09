#!/bin/bash

TCR_TEST_STUB_FILE_ROOT_PATH='./spec/tmp'
TCR_TEST_STUB_FILE_EXTENSION='txt'
test_stub_reset() {
    find "$TCR_TEST_STUB_FILE_ROOT_PATH" -type f -name "*.$TCR_TEST_STUB_FILE_EXTENSION" -delete
}