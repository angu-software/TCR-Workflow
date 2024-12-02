#!/bin/bash

source "$TCR_HOME/lib/error.sh"

TCR_ERROR_TCR_ALREADY_ENABLED="$(error_build 1 'TCR is already enabled')"
TCR_ERROR_TCR_UNKNOWN_ACTION="$(error_build 2 'Unknown action')"
TCR_ERROR_TCR_NOT_ENABLED="$(error_build 3 'TCR is not enabled')"
TCR_ERROR_TCR_ARGUMENTS_MISSING="$(error_build 4 'No arguments specified')"