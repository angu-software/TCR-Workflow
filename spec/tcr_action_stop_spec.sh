#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr disable'

    Include './spec/test_doubles/time_dummy.sh'

    Describe 'when disabling tcr mode'

        tcr_load_session_info() {
            return 0
        }

        subject() {
            tcr stop
        }

        Context 'When trc watch is not running'
            setup() {
                export TCR_OUTPUT_SILENT='true'
                setup_file_mock
            }
            teardown() {
                setup_file_mock
                unset TCR_OUTPUT_SILENT
            }
            BeforeEach 'setup'
            AfterEach 'teardown'

            It 'should delete the tcr lock file'
                When call subject
                The variable FILE_SYSTEM_STUB_RM should include 'rm -f /current/work/directory/.tcr.lock'
            End

            It 'should inform that tcr mode is disabled'
                unset TCR_OUTPUT_SILENT

                When call subject
                The output should eq "$(cat <<-OUTPUT
[$TEST_TIME] Stopping TCR session...
[$TEST_TIME] TCR session stopped.
OUTPUT
)"
            End

            Context 'When tcr was started with session name'
                BeforeEach 'TCR_SESSION_NAME="my cool session"'

                It 'It tells the session with name has ended'
                    unset TCR_OUTPUT_SILENT

                    When call subject
                    The output should eq "$(cat <<-OUTPUT
[$TEST_TIME] Stopping TCR session 'my cool session'...
[$TEST_TIME] TCR Session 'my cool session' stopped.
OUTPUT
)"
                End
            End
        End

        Context 'When tcr watch is running'
            
            tcr_action_watch_stop() { 
                TEST_TCR_WATCH_IS_RUNNING=''
            }

            tcr_action_watch_is_running() { 
                is_set "$TEST_TCR_WATCH_IS_RUNNING"
            }

            BeforeEach 'TEST_TCR_WATCH_IS_RUNNING=true'

            It 'It stops tcr watch'
                unset TCR_OUTPUT_SILENT

                When call subject
                The result of function tcr_action_watch_is_running should not be successful
            End
        End
    End
End