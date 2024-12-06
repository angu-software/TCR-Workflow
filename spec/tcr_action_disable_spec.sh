#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr disable'

    Describe 'when disabling tcr mode'

        Context 'When trc watch is not running'
            setup() {
                export TCR_OUTPUT_SILENT='true'
                setup_exit_mock
                setup_file_mock
            }
            teardown() {
                setup_exit_mock
                setup_file_mock
                unset TCR_OUTPUT_SILENT
            }
            BeforeEach 'setup'
            AfterEach 'teardown'
            
            BeforeEach 'tcr enable'

            It 'should delete the tcr lock file'
                When call tcr 'disable'
                The variable FILE_SYSTEM_STUB_RM should include 'rm -f /current/work/directory/.tcr.lock'
            End

            It 'should inform that tcr mode is disabled'
                unset TCR_OUTPUT_SILENT

                When call tcr 'disable'
                The output should eq '[TCR] OFF'
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

                When call tcr 'disable'
                The result of function tcr_action_watch_is_running should not be successful
            End
        End
    End
End