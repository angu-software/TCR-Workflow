#!bin/bash

create_file() {
    local file_path="$1"
    
    touch "$file_path"
}

remove_file() {
    local file_path="$1"

    rm -f "$file_path"
}

is_file_existing() {
    local file_path="$1"

    [ -f "$file_path" ]
}

file_set_content() {
    local content="$1"
    local file_path="$2"

    echo "$content" > "$file_path"
}