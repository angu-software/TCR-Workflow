#!/bin/bash

source "$TCR_HOME/lib/condition_tests.sh"

TCR_OUTPUT_STDOUT='>&1'
TCR_OUTPUT_STDERR='>&2'

TCR_OUTPUT_STATUS_MSG_PREFIX='[TCR]'

print_set_quiet() {
    TCR_OUTPUT_SILENT='true'
}

print_unset_quiet() {
    unset TCR_OUTPUT_SILENT
}

print() {
    local message="$1"
    local output="${2:-$TCR_OUTPUT_STDOUT}"

    if is_set "$TCR_OUTPUT_SILENT"; then
        return
    fi
    
    if [ "$output" == "$TCR_OUTPUT_STDOUT" ]; then
        echo "$message" >&1
    elif [ "$output" == "$TCR_OUTPUT_STDERR" ]; then
        echo "$message" >&2
    fi
}

print_status() {
    local message="$1"

    print "${TCR_OUTPUT_STATUS_MSG_PREFIX} $message"
}