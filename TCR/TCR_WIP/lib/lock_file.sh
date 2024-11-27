#!/bin/bash

source "$TCR_HOME/lib/path.sh"
source "$TCR_HOME/lib/file.sh"

TCR_LOCK_FILE_NAME='.tcr.lock'

lock_file_current_path() {
    path_join "$TCR_WORK_DIRECTORY" "$TCR_LOCK_FILE_NAME"
}

lock_file_create() {
    file_create "$(lock_file_current_path)"
}

lock_file_remove() {
    file_remove "$(lock_file_current_path)"
}

lock_file_is_existing() {
    file_is_existing "$(lock_file_current_path)"
}

lock_file_set_content() {
    local content="$1"

    file_set_content "$content" "$(lock_file_current_path)"
}