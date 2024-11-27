#!/bin/bash

source './spec/test_doubles/home_dir_mock.sh'

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

    Describe 'error_raise'
        It 'should print the error message to stderr'
            When call error_raise "$ERROR"
            The error should eq 'Some strange error'
            The variable TCR_TEST_EXIT_STATUS should eq 1
        End
    End

    Describe 'error_build'
        It 'should return an error with the given code and message'
            When call error_build 2 'Another error'
            The output should eq '2|[TCR Error] Another error'
        End
    End
End