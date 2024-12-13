#!/bin/bash

source './spec/test_doubles/home_dir_mock.sh'
source './lib/foundation.sh'

source './lib/tcr/actions/tcr_action_watch.sh'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr_action_watch'

    Include './spec/test_doubles/time_dummy.sh'

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
        if [ ! -f "$TEST_CALL_LOG_FILE" ]; then
            return
        fi

        log="$(<"$TEST_CALL_LOG_FILE")"
        echo "$log"
    }

    test_spy_watch_directory_loop_start_reset() {
        if [ -f "$TEST_CALL_LOG_FILE" ]; then
            file_remove "$TEST_CALL_LOG_FILE"
        fi
    }

    subject() {
        tcr_action_watch
    }

    AfterEach 'test_spy_watch_directory_loop_start_reset'

    Context 'When tcr is disabled'
        BeforeAll 'unset TEST_TCR_ENABLED'

        It 'It raises an error'
            When call subject
            The error should eq "[$TEST_TIME] Error: TCR is not enabled!"
            The status should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
        End
    End

    Context 'When executing watch action'

        It 'It tells that it starts watching for changes'
            When call subject
            The output should eq "[$TEST_TIME] Start watching for changes..."
        End

        It 'It starts a loop to watches for changes'
            When call subject
            The output should be present
            The variable TCR_ACTION_WATCH_LOOP_PROCESS_ID should be defined
        End

        It 'It starts a loop with the necessary paramerers'
            When call subject
            The result of function test_spy_watch_directory_loop_start_call_log should eq 'tcr_action_run_on_change'
        End
    End

    Context 'When watch is running'
        Context 'When stopping the watch'
            BeforeEach 'tcr_action_watch'

            watch_directory_loop_is_running() {
                is_set "$(test_spy_watch_directory_loop_start_call_log)"
            }

            watch_directory_loop_stop() {
                test_spy_watch_directory_loop_start_reset
            }

            subject() {
                tcr_action_watch "--stop"
            }

            It 'It stops the watch'
                When call subject
                The result of function tcr_action_watch_is_running should not be successful
            End

            It 'It tells that it stopped watching for changes'
                When call subject
                The output should eq "[$TEST_TIME] Watching for changes stopped."
            End
        End
    End
End