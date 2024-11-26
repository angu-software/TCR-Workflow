#!/bin/bash

source "$TCR_HOME/lib/path.sh"

TCR_LOCK_FILE_NAME='.tcr.lock'

current_lock_file_path() {
    path_join "$TCR_WORK_DIRECTORY" "$TCR_LOCK_FILE_NAME"
}

create_lock_file() {
    touch "$(current_lock_file_path)"
}

remove_lock_file() {
    rm -f "$(current_lock_file_path)"
}

is_lock_file_existing() {
    [ -f "$(current_lock_file_path)" ]
}