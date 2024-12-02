#!/bin/bash

if [ ! -f ".tcr.lock" ]; then
    exit 0
fi

source TCR/XcodeBehavior/tcr.conf

TCR/scripts/commit.sh