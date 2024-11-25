#!/bin/bash

is_enabled=$(echo "$1" | tr '[:upper:]' '[:lower:]')

if [ "$is_enabled" == "on" ]; then
    touch .tcr.lock
    echo "[TCR] ON "
elif [ "$is_enabled" == "off" ]; then
    rm -f .tcr.lock
    echo "[TCR] OFF"
else
    echo "Error: Please specify 'on' or 'off'."
    exit 1
fi