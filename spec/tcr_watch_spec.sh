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

    watch_directory_loop_start() {
        # Mocked away to avoid infinite loop
        echo "$*"
    }

    Context 'When tcr is disabled'
        BeforeAll 'unset TEST_TCR_ENABLED'

        It 'It raises an error'
            When call tcr_action_watch
            The error should eq "$(error_message "$TCR_ERROR_TCR_NOT_ENABLED")"
            The variable TCR_TEST_EXIT_STATUS should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
            The status should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
        End
    End

    Context 'When executing watch action'
        It 'It starts a loop to watches for changes'
            When call tcr_action_watch
            The variable TCR_ACTION_WATCH_LOOP_PROCESS_ID should be defined
            The output should be present
        End

        It 'It starts a loop with the necessary paramerers'
            When call tcr_action_watch
            The output should eq 'tcr_action_run_on_change'
        End
    End
End