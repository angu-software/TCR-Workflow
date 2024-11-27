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
    TCR_RUN_TEST_COMMAND='echo "Running test command"'
    
    TEST_COMMAND_EXIT_STATUS=0
    run_command() {
        TEST_EXECUTED_COMMAND="$TEST_EXECUTED_COMMAND|$1"
        return $TEST_COMMAND_EXIT_STATUS
    }

    #Todo 'tcr run fails with the error code of the executed command after resetting the changes'

    Describe 'When executing tcr with run action'
        It 'It runs the build command'
            When call tcr run
            The variable TEST_EXECUTED_COMMAND should include 'echo "Running build command"'
        End

        Describe 'When the build command succeeds'
            
            It 'It runs the test command'
                When call tcr run
                The variable TEST_EXECUTED_COMMAND should include 'echo "Running test command"'
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
                Pending 'Needs implementation'

                It 'It reverts the changes'
                    When call tcr run
                    The output should eq 'Reverting changes'
                End

                It 'It plays the failure sound'
                    When call tcr run
                    The output should eq 'Playing failure sound'
                End
            End
        End

        Describe 'When the build command fails'
            TEST_COMMAND_EXIT_STATUS=99

            It 'It raises an error'
                When call tcr run
                The error should eq '[TCR Error] Build failed with status 99'
                The variable TCR_TEST_EXIT_STATUS should eq 99
                The status should eq 99
            End

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