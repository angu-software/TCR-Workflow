#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"

tcr_is_enabled() {
    lock_file_is_existing
}