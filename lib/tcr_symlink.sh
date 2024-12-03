#!/bin/bash

source './tcr'

SYMLINK_DESTINATION_PATH="/usr/local/bin"
SYMLINK_PATH="$SYMLINK_DESTINATION_PATH/tcr"

TCR_HOME="$(file_absolute_dir_path "./tcr")"
TCR_FILE="$TCR_HOME/tcr"

create_symlink() {
    ln -s "$TCR_FILE" "$SYMLINK_PATH"
}

delete_symlink() {
    rm "$SYMLINK_PATH"
}