#!/bin/bash

is_enabled=$1

if [ -n "$is_enabled" ]; then
    touch .tcr.lock
else
    rm -f .tcr.lock
fi