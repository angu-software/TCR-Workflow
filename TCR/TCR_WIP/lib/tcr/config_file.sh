#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"

TCR_CONFIG_FILE_EXTENSION='.tcrcfg'
TCR_CONFIG_FILE_DEFAULT_NAME='tcr'

config_file_create() {
    local config_name
    config_name="${TCR_CONFIG_FILE_DEFAULT_NAME}${TCR_CONFIG_FILE_EXTENSION}"
    
    local config_path
    config_path="$(path_join "$TCR_WORK_DIRECTORY" "$config_name")"

    file_create "$config_path"
}

config_file_exists_in_dir() {
    local search_dir="$1"

    files=$(config_file_find_in_dir "$search_dir")

    is_set "$files"
}

config_file_find_in_dir() {
    local search_dir="$1"

    file_find "$1" "*${TCR_CONFIG_FILE_EXTENSION}"
}