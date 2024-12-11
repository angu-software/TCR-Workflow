#!/bin/bash

LOCK_FILE_PATH='./.tcr_playground_loop.lock'
touch "$LOCK_FILE_PATH"

FOLDER_PATH='./TCR_MVP'

some_function() {
    echo "ERR: Some function called..." >&2
    exit 1
}

CURRENT_CHANGES="$(find "$FOLDER_PATH" -name "*" | xargs stat -f "%Sa %N" | sort)"
PREV_CHANGES="$CURRENT_CHANGES"
while [ -f "$LOCK_FILE_PATH" ]; do
    echo "Checking for changes..."

    _="$(some_function)"

    sleep 0.5
done
echo "Exiting TCR loop..."

