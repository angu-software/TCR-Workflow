#!/bin/bash

TCR_ACTION_STATUS='status'

tcr_action_status() {
    if tcr_is_enabled; then
        print_status 'enabled'
    else
        print_status 'disabled'
    fi
}