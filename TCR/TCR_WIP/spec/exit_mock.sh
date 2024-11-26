#!/bin/bash

setup_exit_mock() {
    TCR_EXIT='exit_mock'
    exit_mock() {
        TCR_TEST_EXIT_STATUS="$1"
    }
}