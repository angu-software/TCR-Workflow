#!/bin/bash

source "$TCR_HOME/lib/error.sh"

TCR_ERROR_TCR_ALREADY_ENABLED="$(make_error 1 'TCR is already enabled')"
TCR_ERROR_TCR_UNKNOWN_ACTION="$(make_error 2 'Unknown action')"