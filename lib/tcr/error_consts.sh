#!/bin/bash

source "$TCR_HOME/lib/error.sh"
source "$TCR_HOME/lib/tcr/tcr_error.sh"

TCR_ERROR_TCR_ALREADY_ENABLED="$(tcr_error_build 1 'TCR is already enabled!')"
TCR_ERROR_TCR_UNKNOWN_ACTION="$(tcr_error_build 2 'Unknown action!')"
TCR_ERROR_TCR_NOT_ENABLED="$(tcr_error_build 3 'TCR is not enabled!')"
TCR_ERROR_TCR_ARGUMENTS_MISSING="$(tcr_error_build 4 'No arguments specified!')"
TCR_ERROR_TCR_CFG_MISSING="$(tcr_error_build 5 'No configuration file found!')"