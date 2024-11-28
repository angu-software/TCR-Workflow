#!/bin/bash

source './tcr'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr run'

    setup() {
        setup_exit_mock
    }
    teardown() {
        setup_exit_mock
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

    TCR_RUN_BUILD_COMMAND='echo "Running build command"'
    TCR_RUN_BUILD_COMMAND_EXIT_STATUS=0
    
    TCR_RUN_TEST_COMMAND='echo "Running test command"'
    TCR_RUN_TEST_COMMAND_EXIT_STATUS=0

    TCR_RUN_REVERT_COMMAND='echo "Reverting changes"'
    TCR_RUN_REVERT_COMMAND_EXIT_STATUS=0

    run_command() {
        new_command="$1"
        TEST_COMMAND_SEQUENCE=$'$TEST_COMMAND_SEQUENCE\n$new_command'

        if [ "$new_command" == "$TCR_RUN_BUILD_COMMAND" ]; then
            TCR_RUN_BUILD_EXECUTED_COMMAND="$new_command"
            return $TCR_RUN_BUILD_COMMAND_EXIT_STATUS
        elif [ "$new_command" == "$TCR_RUN_TEST_COMMAND" ]; then
            TCR_RUN_TEST_EXECUTED_COMMAND="$new_command"
            return $TCR_RUN_TEST_COMMAND_EXIT_STATUS
        elif [ "$new_command" == "$TCR_RUN_REVERT_COMMAND" ]; then
            TCR_RUN_REVERT_EXECUTED_COMMAND="$new_command"
            return $TCR_RUN_REVERT_COMMAND_EXIT_STATUS
        fi
    }

    #Todo 'tcr run fails with the error code of the executed command after resetting the changes'

    Describe 'When executing tcr with run action'
        It 'It runs the build command'
            When call tcr run
            The variable TCR_RUN_BUILD_EXECUTED_COMMAND should eq 'echo "Running build command"'
        End

        Describe 'When the build command succeeds'
            
            It 'It runs the test command'
                When call tcr run
                The variable TCR_RUN_TEST_EXECUTED_COMMAND should eq 'echo "Running test command"'
            End

            Describe 'When the test command succeeds'
                Pending 'Needs implementation'

                It 'It commits the changes'
                    When call tcr run
                    The output should eq 'Committing changes'
                End

                It 'It plays the success sound'
                    When call tcr run
                    The output should eq 'Playing success sound'
                End
            End

            Describe 'When the test command fails'
                TCR_RUN_TEST_COMMAND_EXIT_STATUS=66

                It 'It raises an error'
                    When call tcr run
                    The error should eq '[TCR Error] Testing failed with status 66'
                    The variable TCR_TEST_EXIT_STATUS should eq 66
                End

                It 'It reverts the changes'
                    When call tcr run
                    The error should be present
                    The variable TCR_RUN_REVERT_EXECUTED_COMMAND should eq 'echo "Reverting changes"'
                End

                # Todo it tells that it reverts the changes
                # Todo it revert changes after the test command (call order)

                It 'It plays the failure sound'
                    Pending 'Needs implementation'

                    When call tcr run
                    The output should eq 'Playing failure sound'
                End
            End
        End

        Describe 'When the build command fails'
            TCR_RUN_BUILD_COMMAND_EXIT_STATUS=99

            It 'It raises an error'
                When call tcr run
                The error should eq '[TCR Error] Building failed with status 99'
                The variable TCR_TEST_EXIT_STATUS should eq 99
            End

            # Todo it should not revert the changes

            It 'It plays the failure sound'
                Pending 'Needs implementation'

                When call tcr run
                The output should eq 'Playing failure sound'
            End
        End

        Describe 'When tcr is not enabled'
            Pending 'Needs implementation'

            It 'it raises an error'
                When call tcr run
                The error should eq 'TCR is not enabled'
                The variable TCR_TEST_EXIT_STATUS should eq 1
            End
        End
    End
End