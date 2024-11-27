#!/bin/bash

# Error format: "<error_code>|<error_message>"

TCR_ERROR_MSG_PREFIX='[TCR Error]'

make_error() {
    local code="$1"
    local message="$2"

    echo "${code}|${TCR_ERROR_MSG_PREFIX} ${message}"
}