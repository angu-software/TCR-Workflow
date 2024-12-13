#!/bin/bash

source "$TCR_HOME/lib/print.sh"

TCR_EXIT_CMD='exit'

# Error structure:
# <error_code>|<error_message>

# DEPRECATED
TCR_ERROR_MSG_PREFIX='[TCR Error]'

# DEPRECATED: Use tcr_error_build instead
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

# DEPRECATED: Use tcr_error_build instead
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