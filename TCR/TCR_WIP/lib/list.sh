#!/bin/bash

# List is required to consisting of newline separated strings
list_first_entry() {
    echo "$1" | head -n 1
}