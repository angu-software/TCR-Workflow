#!/bin/bash

source './tcr'

DESTINATION_PATH="/usr/local/bin"
TCR_HOME="$(file_absolute_dir_path "./tcr")"
TCR_FILE="$TCR_HOME/tcr"

create_symlink() {
    ln -s "$TCR_FILE" "$DESTINATION_PATH/tcr"
}

echo "Installing TCR..."
if create_symlink; then
    echo "TCR has been installed successfully!"
else
    echo "Failed to install TCR!"
fi