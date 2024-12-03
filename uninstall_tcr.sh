#!/bin/bash

source './lib/tcr_symlink.sh'

echo "Uninstalling TCR..."
if delete_symlink; then
    echo "TCR has been uninstalled successfully!"
else
    echo "Failed to uninstall TCR!"
fi