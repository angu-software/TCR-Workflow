#!/bin/bash

source "$TCR_HOME/lib/tcr/tcr_foundation.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"

TCR_ACTION_STATUS='status'

tcr_action_status() {
    local session_state="Inactive"
    local session_start="Never"
    local session_name="None"
    local session_watch_running="No"

    if tcr_is_enabled; then
        session_state="Active"

        tcr_load_session_info
        
        if is_set "$(tcr_session_start_date_time)"; then
            session_start="$(tcr_session_start_date_time)"
        fi

        if is_set "$(tcr_session_name)"; then
            session_name="$(tcr_session_name)"
        fi

        if tcr_action_watch_is_running; then
            session_watch_running="Yes"
        fi
    fi

    tcr_action_status_print "$session_state" "$session_start" "$session_name" "$session_watch_running"
}

tcr_action_status_print() {
    print "TCR Status: $1"
    tcr_print_separator
    print "Started: $2"
    print "Session Name: $3"
    print "Monitoring for Changes: $4"
}