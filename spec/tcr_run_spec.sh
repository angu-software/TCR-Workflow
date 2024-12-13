#!/bin/bash

source './tcr'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr run'

    time_now() {
        echo "12:34:56"
    }

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
        fi
    }

    tcr_is_enabled() {
        is_unset "$TEST_TCR_DISABLED"
    }

    TEST_DID_CALL_TCR_LOAD_CONFIG=''
    TEST_CFG_FILE_PATH='./spec/fixtures/config_fixture.tcrcfg'
    file_load_as_source() {
        TEST_DID_CALL_TCR_LOAD_CONFIG='true'

        source "$TEST_CFG_FILE_PATH"
    }

    subject() {
        tcr run
    }

    Describe 'When executing tcr with run action'
        BeforeEach 'unset TEST_DID_CALL_TCR_LOAD_CONFIG'

        It 'It loads the configuration file'
            When call subject
            The variable TEST_DID_CALL_TCR_LOAD_CONFIG should be defined
        End

        Context 'When a config file was found'

            It 'It runs the build command from the loaded config'
                When call subject
                The variable TCR_RUN_BUILD_EXECUTED_COMMAND should eq "$TCR_BUILD_CMD"
            End

            It 'It tells that it builds the changes'
                print_unset_quiet

                When call subject
                The output should include '[12:34:56] Building project...'
            End

            Context 'When no build command is set in the cfg file'
                TEST_CFG_FILE_PATH='./spec/fixtures/config_fixture_no_build_cmd.tcrcfg'

                It 'It skipps the build phase'
                    When call subject
                    The variable TCR_RUN_BUILD_EXECUTED_COMMAND should be blank
                End

                It 'It tells that it is skipping the build command'
                    print_unset_quiet

                    When call subject
                    The output should include '[12:34:56] Skipping Build phase, no command specified.'
                    The output should not include '[12:34:56] Building project...'
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
                    The output should include '[12:34:56] Running tests...'
                End

                Describe 'When the test command succeeds'
                    It 'It commits the changes using the command from the config'
                        When call subject
                        The variable TCR_RUN_COMMIT_EXECUTED_COMMAND should eq "$TCR_COMMIT_CMD"
                    End
                End
            End
        End

        Describe 'When tcr is not enabled'
            TEST_TCR_DISABLED='true'

            It 'It raises an error'
                unset TCR_OUTPUT_SILENT

                When call subject
                The error should eq '[TCR Error] TCR is not enabled'
                The status should eq 3
            End
        End
    End
End