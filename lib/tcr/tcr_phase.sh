#!/bin/bash

source "$TCR_HOME/lib/foundation.sh"
source "$TCR_HOME/lib/tcr/tcr_print.sh"

# Phase structure:
# <id>|<name>|<event_message>|<success_message>|<failure_message>

TCR_BUILD_PHASE="build|Build|Building project...|Build successful.|Build failing."
TCR_TEST_PHASE="test|Test|Running tests...|All tests passed.|Tests are failing."
TCR_COMMIT_PHASE="commit|Commit|Committing changes...|Changes committed successfully.|Commiting failed."
TCR_REVERT_PHASE="revert|Revert|Reverting changes...|Changes reverted successfully.|Reverting failed."

tcr_phase_exec() {
    phase="$1"
    command="$2"

    phase_name="$(tcr_phase_get_name "$phase")"
    phase_message="$(tcr_phase_get_event_message "$phase")"
    phase_success_message="$(tcr_phase_get_success_message "$phase")"
    phase_failure_message="$(tcr_phase_get_failure_message "$phase")"

    tcr_print_event "$phase_message"
    tcr_print_header "$phase_name Output"

    command_run "$command"
    cmd_exit="$?"

    if is_success "$cmd_exit"; then
        tcr_print_footer_event "$phase_success_message"
    else 
        tcr_print_footer_event "$phase_failure_message"
    fi

    return "$cmd_exit"
}

tcr_phase_get_name() {
    phase="$1"
    echo "$phase" | cut -d'|' -f2
}

tcr_phase_get_event_message() {
    phase="$1"
    echo "$phase" | cut -d'|' -f3
}

tcr_phase_get_success_message() {
    phase="$1"
    echo "$phase" | cut -d'|' -f4
}

tcr_phase_get_failure_message() {
    phase="$1"
    echo "$phase" | cut -d'|' -f5
}