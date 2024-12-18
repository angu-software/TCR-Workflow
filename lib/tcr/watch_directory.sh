#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"

TCR_WATCH_DIR_LOCK_FILE_NAME='tcr_watch.lock'
TCR_WATCH_DIR_LOCK_FILE_PATH="$TCR_WORK_DIRECTORY/$TCR_WATCH_DIR_LOCK_FILE_NAME"

TCR_ERROR_WATCH_RUNNING="$(tcr_error_build 30 'TCR is already watching for changes')"

watch_directory_loop_start() {
    repeating_cmd="$1"
    if ! is_set "$repeating_cmd"; then
        return
    fi

    if watch_directory_loop_is_running; then
        tcr_error_raise "$TCR_ERROR_WATCH_RUNNING"
        return "$(latest_error_code)"
    fi

    watch_directory_create_lock_file

    while watch_directory_loop_should_run; do
        command_run "$repeating_cmd"
        watch_directory_idle
    done

    watch_directory_remove_lock_file
}

watch_directory_idle() {
    sleep 0.3
}

watch_directory_loop_is_running() {
    file_is_existing "$TCR_WATCH_DIR_LOCK_FILE_PATH"
}

watch_directory_loop_should_run() {
    file_is_existing "$TCR_WATCH_DIR_LOCK_FILE_PATH"
}

watch_directory_create_lock_file() {
    file_create "$TCR_WATCH_DIR_LOCK_FILE_PATH"
}

watch_directory_remove_lock_file() {
    file_remove "$TCR_WATCH_DIR_LOCK_FILE_PATH"
}

watch_directory_loop_stop() {
    watch_directory_remove_lock_file
}