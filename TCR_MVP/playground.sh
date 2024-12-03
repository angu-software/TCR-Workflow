#!/bin/bash

LOCK_FILE_PATH='./.trc_loop.lock'
touch "$LOCK_FILE_PATH"

FOLDER_PATH='./TCR_MVP'

CURRENT_CHANGES="$(find "$FOLDER_PATH" -name "*" | xargs stat -f "%Sa %N" | sort)"
PREV_CHANGES="$CURRENT_CHANGES"
while [ -f "$LOCK_FILE_PATH" ]; do
    CURRENT_CHANGES="$(find "$FOLDER_PATH" -name "*" | xargs stat -f "%Sa %N" | sort)"
    if [ "$CURRENT_CHANGES" != "$PREV_CHANGES" ]; then
        echo "Changes detected!"
        PREV_CHANGES="$CURRENT_CHANGES"
    fi
    sleep 0.5
done
echo "Exiting TCR loop..."

