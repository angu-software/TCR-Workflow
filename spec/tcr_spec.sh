#!/bin/bash

source './tcr'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr'

    Include './spec/test_doubles/time_dummy.sh'

    Describe 'When passing unknown arguments'
        It 'It should raise an error'
            unset TCR_OUTPUT_SILENT

            When call tcr 'unknown'
            The error should eq "[$TEST_TIME] Error: Unknown action!"
            The status should eq "$(error_code "$TCR_ERROR_TCR_UNKNOWN_ACTION")"
        End
    End

    Describe 'When passing no arguments'
        It 'It should raise an error'
            unset TCR_OUTPUT_SILENT

            When call tcr
            The error should eq "[$TEST_TIME] Error: No arguments specified!"
            The status should eq "$(error_code "$TCR_ERROR_TCR_ARGUMENTS_MISSING")"
        End
    End

    Context 'tcr --help'
        It 'should show the help message'
            When call tcr '--help'
            The output should include 'Usage:'
            The output should include 'Actions:'
        End
    End

    Context 'tcr --version'
        It 'should show the version'
            When call tcr '--version'
            The output should eq "[TCR] v$TCR_VERSION"
        End
    End

    Context 'When specifying actions'
        TEST_ACTION_CALLED=''
        tcr_action_watch() {
            TEST_ACTION_CALLED="_watch_ $*"
        }

        subject() {
            tcr watch '--stop'
        }

        It 'It calls the action'
            When call subject
            The variable TEST_ACTION_CALLED should eq '_watch_ --stop'
        End
    End

    Context 'When specifying actions with arguments'
        TEST_ACTION_ARGS=('--some-args' '--some-other-args')

        tcr_run_action() {
            TEST_ACTION_WITH_ARGS="$*"
        }

        subject() {
            tcr watch "${TEST_ACTION_ARGS[@]}"
        }

        It 'Forwards all arguments to the action'
            When  call subject
            The variable TEST_ACTION_WITH_ARGS should eq "watch ${TEST_ACTION_ARGS[*]}"
        End
     End
End