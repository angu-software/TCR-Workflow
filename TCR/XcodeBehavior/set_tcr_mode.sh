#!/bin/bash
set -e
#set -x

ON="ON"
OFF="OFF"

TRC_LOCK_FILE=".tcr.lock"

create_file() {
    touch "$1"
}

delete_file() {
    rm -f "$1"
}

enable_tcr() {
    create_file $TRC_LOCK_FILE
}

disable_tcr() {
    delete_file $TRC_LOCK_FILE
}

to_uppercase() {
    echo "$1" | tr '[:lower:]' '[:upper:]'
}

# --- Public

set_tcr_mode() {
    mode=$(to_uppercase "$1")

    if [ "$mode" == "$ON" ]; then
        enable_tcr
    elif [ "$mode" == "$OFF" ]; then
        disable_tcr
    else
        echo "Error: Please specify '$ON' or '$OFF'."
        exit 1
    fi

    echo "[TCR] $mode"
}

# --- Main

if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    set_tcr_mode "$1"
fi