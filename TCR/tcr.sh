#!/bin/bash

#echo "[TCR] Building ..."
./scripts/buildIt.sh

#echo "[TCR] Testing ..."
if ./scripts/test.sh; then
    echo "[TCR] Committing changes"
    ./scripts/commit.sh
else
    echo "[TCR] Reverting changes"
    ./scripts/revert.sh
fi