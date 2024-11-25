#!/bin/bash

source ./tcr.conf

trap "echo [TCR] Stopped; exit;" SIGINT SIGTERM

echo "[TCR] Started"

while true
do
    echo "[TCR] Observing changes in ${TCR_SOURCES_PATHS}"
    fswatch -1 -x --event Created --event Removed --event Updated --event Renamed ${TCR_SOURCES_PATHS}
    echo "[TCR] Evaluating changes ..."
    ./tcr.sh
    echo "---"
done