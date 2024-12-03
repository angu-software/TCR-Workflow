#!/bin/bash

source "$TCR_HOME/tcr_version.sh"
source "$TCR_HOME/lib/foundation.sh"

TCR_CONFIG_FILE_EXTENSION='.tcrcfg'
TCR_CONFIG_FILE_DEFAULT_NAME='tcr'

config_file_create() {  
    local config_path
    config_path="$(path_join "$TCR_WORK_DIRECTORY" "$(config_file_template_file_name)")"

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

config_file_find_first_in_dir() {
    local search_dir="$1"
    local found_files

    found_files=$(config_file_find_in_dir "$search_dir")

    list_first_entry "$found_files"
}

config_file_create_template() {
    local config_path
    config_path="$(config_file_template_file_path)"

    file_create "$config_path"
    file_set_content "$(config_file_template_content)" "$config_path"
}

config_file_template_file_path() {
    local config_name
    config_name="${TCR_CONFIG_FILE_DEFAULT_NAME}${TCR_CONFIG_FILE_EXTENSION}"
    
    path_join "$TCR_WORK_DIRECTORY" "$config_name"
}

config_file_template_file_name() {
    echo "${TCR_CONFIG_FILE_DEFAULT_NAME}${TCR_CONFIG_FILE_EXTENSION}"
}

config_file_template_content() {
    cat <<-CONFIG
# TCR Configuration File
# TCR version: $TCR_VERSION
#
# This configuration file is used to set up the commands for the TCR (Test && Commit || Revert) workflow.
# The TCR workflow automates the process of running tests, committing changes if tests pass, and reverting changes if tests fail.

# -- Build command (Optional) --
# Command to build the project before running tests.
# If the build command is not specified, the tests will be run without building the project.
# If the build command fails, tcr will simply fail without any further command execution.
#
# TCR_BUILD_CMD=''

# -- Test command --
# Command to run the tests.
# This command should return a non-zero exit code if tests fail.
#
TCR_TEST_CMD=''

# -- Commit command --
# Command to commit the changes if tests pass.
#
TCR_COMMIT_CMD='git add . && git commit -m "[TCR] Changes working"'

# -- Revert command --
# Command to revert the changes if tests fail.
# Typically reverts the working directory to the last committed state.
# Revert command
# Command to revert the changes if tests fail.
# Typically reverts the working directory to the last committed state.
# Alternatively, you can define other, less destructive commands to handle the revert process, such as:
# - Reverting only changes in tracked files
# - Stashing the changes
# - Reverting only unstaged changes
#
TCR_REVERT_CMD='git reset --hard'

CONFIG
}