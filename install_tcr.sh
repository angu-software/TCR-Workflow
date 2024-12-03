#!/bin/bash

source './lib/tcr_symlink.sh'

echo "Installing TCR..."
if create_symlink; then
    echo "TCR has been installed successfully!"
else
    echo "Failed to install TCR!"
fi