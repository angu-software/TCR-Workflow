#!/bin/bash

source './tcr'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr run'

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
                unset TCR_OUTPUT_SILENT

                When call subject
                The output should include '[TCR] Building changes'
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
                    The output should include '[TCR] Skipping Building phase'
                    The output should not include '[TCR] Building changes'
                End
            End

            Describe 'When the build command succeeds'
                
                It 'It runs the test command from the loaded config'
                    When call subject
                    The variable TCR_RUN_TEST_EXECUTED_COMMAND should eq "$TCR_TEST_CMD"
                End

                It 'It tells that it runs the tests'
                    unset TCR_OUTPUT_SILENT

                    When call subject
                    The output should include '[TCR] Testing changes'
                End

                Describe 'When the test command succeeds'
                    It 'It commits the changes using the command from the config'
                        When call subject
                        The variable TCR_RUN_COMMIT_EXECUTED_COMMAND should eq "$TCR_COMMIT_CMD"
                    End

                    It 'It tells that it commits the changes'
                        unset TCR_OUTPUT_SILENT

                        When call subject
                        The output should include '[TCR] Committing changes'
                        The error should not be present
                    End

                    Context 'When the commit command is failing'
                        TEST_TCR_COMMIT_CMD_EXIT_STATUS=88

                        It 'It raises an error'
                            unset TCR_OUTPUT_SILENT

                            When call subject
                            The output should be present
                            The error should eq '[TCR Error] Committing failed with status 88'
                            The status should eq 88
                        End
                    End
                End

                Describe 'When the test command fails'
                    TEST_TCR_TEST_CMD_EXIT_STATUS=66

                    It 'It raises an error'
                        unset TCR_OUTPUT_SILENT

                        When call subject
                        The output should be present
                        The error should eq '[TCR Error] Testing failed with status 66'
                        The status should eq 66
                    End

                    It 'It reverts the changes using the command from the loaded config'
                        unset TCR_OUTPUT_SILENT

                        When call subject
                        The output should be present
                        The error should be present
                        The status should be failure
                        The variable TCR_RUN_REVERT_EXECUTED_COMMAND should eq "$TCR_REVERT_CMD"
                    End

                    It 'It tells that it reverts the changes'
                        unset TCR_OUTPUT_SILENT

                        When call subject
                        The output should include '[TCR] Reverting changes'
                        The error should be present
                        The status should be failure
                    End

                    Context 'When the revert command is failing'
                        TEST_TCR_REVERT_CMD_EXIT_STATUS=77

                        It 'It raises an error'
                            unset TCR_OUTPUT_SILENT

                            When call subject
                            The output should be present
                            The error should eq '[TCR Error] Reverting failed with status 77'
                            The status should eq 77
                        End
                    End
                End
            End
        End

        Describe 'When the build command fails'
            TEST_TCR_BUILD_CMD_EXIT_STATUS=99

            It 'It raises an error'
                unset TCR_OUTPUT_SILENT

                When call subject
                The output should be present
                The error should eq '[TCR Error] Building failed with status 99'
                The status should eq 99
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