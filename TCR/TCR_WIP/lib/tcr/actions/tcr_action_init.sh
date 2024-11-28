#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"

TCR_ACTION_INIT='init'

TCR_ERROR_TCR_INIT_CFG_EXISTS="$(error_build 10 'Config file already exists')"

# Create template config
# Do not create template cfg when it already exists
# Template contains default reset and commit commands
# Optional config name can be passed as argument

tcr_action_init() {

    if config_file_exists_in_dir "$TCR_WORK_DIRECTORY"; then
        error_raise "$TCR_ERROR_TCR_INIT_CFG_EXISTS"
        return
    fi

    config_file_create
}

# -- config_file.sh -- #

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

file_find() {
    local search_dir="$1"
    local file_name_glob="$2"

    find "$search_dir" -maxdepth 1 -type f -name "$file_name_glob"
}