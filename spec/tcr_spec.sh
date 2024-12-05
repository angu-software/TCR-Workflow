#!/bin/bash

source './tcr'

source './spec/test_doubles/exit_mock.sh'

Describe 'tcr'

    Describe 'When passing unknown arguments'
        It 'It should raise an error'
            unset TCR_OUTPUT_SILENT

            When call tcr 'unknown'
            The error should eq "$(error_message "$TCR_ERROR_TCR_UNKNOWN_ACTION")"
            The variable TCR_TEST_EXIT_STATUS should eq "$(error_code "$TCR_ERROR_TCR_UNKNOWN_ACTION")"
        End
    End

    Describe 'When passing no arguments'
        It 'It should raise an error'
            unset TCR_OUTPUT_SILENT

            When call tcr
            The error should eq "$(error_message "$TCR_ERROR_TCR_ARGUMENTS_MISSING")"
            The variable TCR_TEST_EXIT_STATUS should eq "$(error_code "$TCR_ERROR_TCR_ARGUMENTS_MISSING")"
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
End