#!/bin/bash


is_set() {
    [ -n "$1" ]
}

is_unset() {
    [ -z "$1" ]
}