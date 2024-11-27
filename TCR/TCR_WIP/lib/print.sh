#!/bin/bash

# set TCR_OUTPUT_SILENT to silence the output
# usually used for testing

TCR_OUTPUT_STDOUT='>&1'
TCR_OUTPUT_STDERR='>&2'

TCR_OUTPUT_STATUS_MSG_PREFIX='[TCR]'

print() {
    local message="$1"
    local output="${2:-$TCR_OUTPUT_STDOUT}"

    if [ -n "$TCR_OUTPUT_SILENT" ]; then
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