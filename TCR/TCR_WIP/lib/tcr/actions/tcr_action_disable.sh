#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/lock_file.sh"

TCR_ACTION_DISABLE='disable'

tcr_action_disable() {
    lock_file_remove
    print_status 'OFF'
}