#!/bin/bash

#echo "[TCR] Building ..."
if ./scripts/buildIt.sh; then
    #echo "[TCR] Testing ..."
    if ./scripts/test.sh; then
        echo "[TCR] Committing changes"
        ./scripts/commit.sh
        ./scripts/play_sound.sh "${TCR_SUCCESS_SOUND}"
    else
        echo "[TCR] Reverting changes"
        ./scripts/revert.sh
        ./scripts/play_sound.sh "${TCR_FAILURE_SOUND}"
    fi
fi