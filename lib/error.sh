#!/bin/bash

source "$TCR_HOME/lib/print.sh"

TCR_EXIT_CMD='exit'

# Error format: "<error_code>|<error_message>"

TCR_ERROR_MSG_PREFIX='[TCR Error]'

error_build() {
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

error_raise() {
    local error="$1"
    local error_code
    error_code="$(error_code "$error")"

    print "$(error_message "$error")" "$TCR_OUTPUT_STDERR"
    $TCR_EXIT_CMD "$error_code"
}

latest_error_code() {
    echo "$?"
}

last_command_status() {
    latest_error_code
}