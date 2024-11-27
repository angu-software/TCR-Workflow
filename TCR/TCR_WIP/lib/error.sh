#!/bin/bash

source "$TCR_HOME/lib/print.sh"

TCR_EXIT='exit'

# Error format: "<error_code>|<error_message>"

TCR_ERROR_MSG_PREFIX='[TCR Error]'

make_error() {
    local code="$1"
    local message="$2"

    echo "${code}|${TCR_ERROR_MSG_PREFIX} ${message}"
}

error_message() {
    local error="$1"

    IFS='|' read -r _ message <<< "$error"
    echo "$message"
}

error_code() {
    local error="$1"

    IFS='|' read -r code _ <<< "$error"
    echo "$code"
}

raise_error() {
    local error="$1"

    print "$(error_message "$error")" "$TCR_OUTPUT_STDERR"
    $TCR_EXIT "$(error_code "$error")"
}