#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"

tcr_print_event() {
    if is_unset "$*"; then
        return
    fi

    print "[$(time_now)] $*"
}

tcr_print_error_event() {
    tcr_print_event "Error: $*" >&2
}

tcr_print_header() {
    if is_unset "$*"; then
        return
    fi

    print "[$*]"
    tcr_print_separator
}

tcr_print_footer() {
    if is_unset "$*"; then
        return
    fi

    tcr_print_separator
    print "$*"
}

tcr_print_footer_event() {
    tcr_print_footer "$(tcr_print_event "$@")"
}

tcr_print_separator() {
    print "--------------------------------------------------"
}
