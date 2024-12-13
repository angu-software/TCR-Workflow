#!/bin/bash

source "$TCR_HOME/lib/tcr/tcr_print.sh"

TCR_ACTION_STATUS='status'

tcr_action_status() {
    if tcr_is_enabled; then
        local session_name
        session_name="$(tcr_session_name)"
        
        if is_unset "$session_name"; then
            session_name="None"
        fi

        watch_running="No"
        if tcr_action_watch_is_running; then
            watch_running="Yes"
        fi

        tcr_action_status_print "Active" "$session_name" "$watch_running"
    else
        tcr_action_status_print "Inactive" "None" "No"
    fi
}

tcr_action_status_print() {
    print "TCR Status: $1"
    tcr_print_separator
    print "Session Name: $2"
    print "Monitoring for Changes: $3"
}