#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"

tcr_is_enabled() {
    lock_file_is_existing
}

tcr_session_name() {
    tcr_load_session_info
    
    echo "$TCR_SESSION_NAME"
}

tcr_load_session_info() {
    source "$TCR_LOCK_FILE_PATH"
}