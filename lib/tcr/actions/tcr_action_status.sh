#!/bin/bash

TCR_ACTION_STATUS='status'

tcr_action_status() {
    if tcr_is_enabled; then
        print_status 'session active'
    else
        print_status 'no session active'
    fi
}