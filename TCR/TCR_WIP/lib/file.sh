#!bin/bash

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