#!/bin/bash

path_join() {
    local delimiter='/'
    local result="$1"
    shift
    for part in "$@"; do
        result="${result}${delimiter}${part}"
    done
    
    echo "$result"
}