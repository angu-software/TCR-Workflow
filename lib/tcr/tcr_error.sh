#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"

tcr_error_build() {
    local code="$1"
    local message="$2"

    echo "${code}|${message}"
}

tcr_error_raise() {
    local error="$1"
    local error_code
    error_code="$(error_code "$error")"

    tcr_print_error_event "$(error_message "$error")"
    $TCR_EXIT_CMD "$error_code"
}