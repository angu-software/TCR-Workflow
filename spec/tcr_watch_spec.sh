#!/bin/bash

source './spec/test_doubles/home_dir_mock.sh'
source './lib/foundation.sh'

source './lib/tcr/actions/tcr_action_watch.sh'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr_action_watch'

    TEST_TCR_ENABLED='true'
    tcr_is_enabled() {
        is_set "$TEST_TCR_ENABLED"
    }

    TEST_CALL_LOG_FILE='./spec/tmp/watch_directory_loop_start.txt'
    watch_directory_loop_start() {
        # Mocked away to avoid infinite loop
        echo "$*" >> "$TEST_CALL_LOG_FILE"
    }

    test_spy_watch_directory_loop_start_call_log() {
        log="$(<"$TEST_CALL_LOG_FILE")"
        echo "$log"
    }

    test_spy_watch_directory_loop_start_reset() {
        file_remove "$TEST_CALL_LOG_FILE"
    }

    AfterEach 'test_spy_watch_directory_loop_start_reset'

    Context 'When tcr is disabled'
        BeforeAll 'unset TEST_TCR_ENABLED'

        It 'It raises an error'
            When call tcr_action_watch
            The error should eq "$(error_message "$TCR_ERROR_TCR_NOT_ENABLED")"
            The status should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
        End
    End

    Context 'When executing watch action'
        It 'It starts a loop to watches for changes'
            When call tcr_action_watch
            The variable TCR_ACTION_WATCH_LOOP_PROCESS_ID should be defined
        End

        It 'It starts a loop with the necessary paramerers'
            When call tcr_action_watch
            The result of function test_spy_watch_directory_loop_start_call_log should eq 'tcr_action_run_on_change'
        End
    End
End