#!/bin/bash

TCR_ACTION_STATUS='status'

tcr_action_status() {
    if tcr_is_enabled; then
        local session_name
        session_name="$(tcr_session_name)"
        
        if is_set "$session_name"; then
            print_status "session '$session_name' active"
        else
            print_status 'session active'
        fi

        if tcr_action_watch_is_running; then
            print_status 'watching for changes'
        fi
    else
        print_status 'no session active'
    fi
}