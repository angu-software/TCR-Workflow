#!/bin/bash

source './spec/test_consts.sh'

source './lib/error.sh'
source './spec/test_doubles/exit_mock.sh'

Describe 'error'
    setup_exit_mock

    BeforeEach 'unset TCR_TEST_EXIT_STATUS'

    ERROR="1|Some strange error"

    Describe 'error_message'
        It 'should return the error message from an error'
            When call error_message "$ERROR"
            The output should eq 'Some strange error'
        End
    End

    Describe 'error_code'
        It 'should return the error code from an error'
            When call error_code "$ERROR"
            The output should eq '1'
        End
    End

    Describe 'raise_error'
        It 'should print the error message to stderr'
            When call raise_error "$ERROR"
            The error should eq 'Some strange error'
            The variable "$TCR_TEST_EXIT_STATUS" should eq 1
        End
    End
End