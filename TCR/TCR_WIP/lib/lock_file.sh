#!/bin/bash

source "$TCR_HOME/lib/path.sh"
source "$TCR_HOME/lib/file.sh"

TCR_LOCK_FILE_NAME='.tcr.lock'

current_lock_file_path() {
    path_join "$TCR_WORK_DIRECTORY" "$TCR_LOCK_FILE_NAME"
}

create_lock_file() {
    create_file "$(current_lock_file_path)"
}

remove_lock_file() {
    remove_file "$(current_lock_file_path)"
}

is_lock_file_existing() {
    is_file_existing "$(current_lock_file_path)"
}

lock_file_set_content() {
    local content="$1"

    file_set_content "$content" "$(current_lock_file_path)"
}