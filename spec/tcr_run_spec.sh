#!/bin/bash

Describe 'tcr run'
    Include './tcr'
    Include './spec/test_doubles/exit_mock.sh'
    Include './spec/test_doubles/config_dummy.sh'
    Include './spec/test_doubles/time_dummy.sh'

    setup() {
        print_set_quiet
        unset $TEST_TCR_DISABLED
    }
    BeforeEach 'setup'

    TEST_TCR_BUILD_CMD_EXIT_STATUS=0
    TEST_TCR_TEST_CMD_EXIT_STATUS=0
    TEST_TCR_COMMIT_CMD_EXIT_STATUS=0
    TEST_TCR_REVERT_CMD_EXIT_STATUS=0

    command_run() {
        new_command="$1"

        if [ "$new_command" == "$TCR_BUILD_CMD" ]; then
            TCR_RUN_BUILD_EXECUTED_COMMAND="$new_command"
            return $TEST_TCR_BUILD_CMD_EXIT_STATUS
        elif [ "$new_command" == "$TCR_TEST_CMD" ]; then
            TCR_RUN_TEST_EXECUTED_COMMAND="$new_command"
            return $TEST_TCR_TEST_CMD_EXIT_STATUS
        elif [ "$new_command" == "$TCR_REVERT_CMD" ]; then
            TCR_RUN_REVERT_EXECUTED_COMMAND="$new_command"
            return $TEST_TCR_REVERT_CMD_EXIT_STATUS
        elif [ "$new_command" == "$TCR_COMMIT_CMD" ]; then
            TCR_RUN_COMMIT_EXECUTED_COMMAND="$new_command"
            return $TEST_TCR_COMMIT_CMD_EXIT_STATUS
        elif [ "$new_command" == "$TCR_NOTIFICATION_SUCCESS_CMD" ]; then
            TEST_DID_EXEC_NOTIFICATION_SUCCESS_CMD="$new_command"
            return 0
        elif [ "$new_command" == "$TCR_NOTIFICATION_FAILURE_CMD" ]; then
            TEST_DID_EXEC_NOTIFICATION_FAILURE_CMD="$new_command"
            return 0
        fi
    }

    tcr_is_enabled() {
        is_unset "$TEST_TCR_DISABLED"
    }

    subject() {
        tcr run
    }

    Describe 'When executing tcr with run action'
        BeforeEach 'unset TEST_ACTION_RUN_CFG_PATH'

        Describe 'When tcr is not enabled'
            BeforeEach "TEST_TCR_DISABLED='true'"

            It 'It raises an error'
                unset TCR_OUTPUT_SILENT

                When call subject
                The error should eq "[$TEST_TIME] Error: TCR is not enabled!"
                The status should eq 3
            End
        End

        It 'It loads the configuration file'
            When call subject
            The variable TCR_ACTION_RUN_CFG_PATH should be defined
        End

        Context 'When a config file was found'

            It 'It tells the tcr run action starts'
                print_unset_quiet

                When call subject
                The line 1 of output should eq "[$TEST_TIME] Starting TCR run..."
            End

            It 'It runs the build command from the loaded config'
                When call subject
                The variable TCR_RUN_BUILD_EXECUTED_COMMAND should eq "$TCR_BUILD_CMD"
            End

            It 'It tells that it builds the changes'
                print_unset_quiet

                When call subject
                The output should include "[$TEST_TIME] Building project..."
            End

            Context 'When no build command is set in the cfg file'
                BeforeEach 'unset TEST_BUILD_CMD'

                It 'It skipps the build phase'
                    When call subject
                    The variable TCR_RUN_BUILD_EXECUTED_COMMAND should be blank
                End

                It 'It tells that it is skipping the build command'
                    print_unset_quiet

                    When call subject
                    The line 2 of output should eq "[$TEST_TIME] Skipping Build phase, no command specified."
                    The output should not eq "[$TEST_TIME] Building project..."
                End

            End

            Describe 'When the build command succeeds'
                
                It 'It runs the test command from the loaded config'
                    When call subject
                    The variable TCR_RUN_TEST_EXECUTED_COMMAND should eq "$TCR_TEST_CMD"
                End

                It 'It tells that it runs the tests'
                    print_unset_quiet

                    When call subject
                    The output should include "[$TEST_TIME] Running tests..."
                End

                Describe 'When the test command succeeds'
                    It 'It commits the changes using the command from the config'
                        When call subject
                        The variable TCR_RUN_COMMIT_EXECUTED_COMMAND should eq "$TCR_COMMIT_CMD"
                    End
                End
            End

            It 'It tells that the tcr run has been completed'
                print_unset_quiet

                When call subject
                The output should include "[$TEST_TIME] TCR run completed."
            End
        End

        Context 'When tcr run was successful'

            BeforeEach "TEST_NOTIFICATION_SUCCESS_CMD='echo \"TCR run successful!\"'"
        
            It 'It notifies the user that the run was successful'
                When call subject
                The variable TEST_DID_EXEC_NOTIFICATION_SUCCESS_CMD should eq "$TEST_NOTIFICATION_SUCCESS_CMD"
            End
        End

        Context 'When tcr run was not successful'
            BeforeEach "TEST_TCR_TEST_CMD_EXIT_STATUS=1; TEST_NOTIFICATION_FAILURE_CMD='echo \"TCR run failed!\"'"
            
            It 'It notifies the user that the run failed'
                When call subject
                The variable TEST_DID_EXEC_NOTIFICATION_FAILURE_CMD should eq "$TEST_NOTIFICATION_FAILURE_CMD"
            End

            Context 'Because build command failed'

                BeforeEach 'TEST_TCR_BUILD_CMD_EXIT_STATUS=1'

                It 'It notifies the user that the run failed'
                    When call subject
                    The variable TEST_DID_EXEC_NOTIFICATION_FAILURE_CMD should eq "$TEST_NOTIFICATION_FAILURE_CMD"
                End
            End
        End
    End
End