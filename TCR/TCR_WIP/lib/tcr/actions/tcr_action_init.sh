#!/bin/bash

TCR_ACTION_INIT='init'

# Create template config
# Do not create template cfg when it already exists
# Template contains default reset and commit commands
# Optional config name can be passed as argument

tcr_action_init() {
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