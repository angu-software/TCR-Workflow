#!/bin/bash

source "$TCR_HOME/lib/print.sh"
source "$TCR_HOME/lib/error_const.sh"

TCR_EXIT='exit'

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