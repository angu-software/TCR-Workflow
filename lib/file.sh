#!/bin/bash

TCR_FIND_CMD='find'

file_create() {
    local file_path="$1"

    touch "$file_path"
}

file_remove() {
    local file_path="$1"

    rm -f "$file_path"
}

file_is_existing() {
    local file_path="$1"

    [ -f "$file_path" ]
}

file_set_content() {
    local content="$1"
    local file_path="$2"

    echo "$content" > "$file_path"
}

file_find() {
    local search_dir="$1"
    local file_name_glob="$2"

    "$TCR_FIND_CMD" "$search_dir" -maxdepth 1 -type f -name "$file_name_glob"
}

file_load_as_source() {
    local file_path="$1"

    source "$file_path"
}