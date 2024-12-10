#!/bin/bash

source './spec/test_doubles/home_dir_mock.sh'

TCR_WORK_DIRECTORY='./spec/fixtures'

source './lib/foundation.sh'

source './lib/tcr/watch_directory.sh'

source './spec/test_doubles/exit_mock.sh'

Describe 'watch_directory'

    AfterEach 'watch_directory_loop_stop'

    Context 'When watching for changes'

        Context 'When no lockfile is present'
            start_test_loop() {
                watch_directory_loop_start "return 0" &
            }

            stop_test_loop() {
                watch_directory_loop_stop
            }

            AfterEach 'stop_test_loop'

            It 'It creates a lock file in the home directory'
                start_test_loop
                sleep 0.3
                The file "$TCR_WATCH_DIR_LOCK_FILE_PATH" should be exist
            End

            Context 'When no command to execute is specified'
                It 'It returns immediately'
                    When call watch_directory_loop_start
                    The file "$TCR_WATCH_DIR_LOCK_FILE_PATH" should not be exist
                End
            End

            Context 'When command to execute is specified'

                test_command() {
                    TEST_COMMAND_EXECUTED='true'
                    watch_directory_loop_stop
                }

                It 'It executes the command in a loop'
                    When call watch_directory_loop_start test_command
                    The variable TEST_COMMAND_EXECUTED should be defined
                End
            End
        End

        Context 'When lockfile is present'
            It 'It raises an error'
                file_create "$TCR_WATCH_DIR_LOCK_FILE_PATH"

                When call watch_directory_loop_start "return 0"
                The error should eq '[TCR Error] TCR is already watching for changes'
                The status should eq 30
            End
        End
    End
End