#!/bin/bash

rm() {
    remove_cmd="rm $*"

    if is_set "$FILE_SYSTEM_STUB_RM"; then
        FILE_SYSTEM_STUB_RM="$FILE_SYSTEM_STUB_RM\n$remove_cmd"
    else 
        FILE_SYSTEM_STUB_RM="$remove_cmd"
    fi
}

test_stub_rm_reset() {
    unset FILE_SYSTEM_STUB_RM
}