#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr enable'

    setup() {
        export TCR_OUTPUT_SILENT='true'
        setup_exit_mock
        setup_file_mock
    }
    teardown() {
        setup_exit_mock
        setup_file_mock
        unset TCR_OUTPUT_SILENT
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

    Describe 'when enabling tcr mode'
        It 'should creates a tcr lock file at the current work directory'
            When call tcr 'enable'
            The variable TCR_TEST_FILE_CREATE_PATH should eq '/current/work/directory/.tcr.lock'
        End
        
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'enable'
            The output should eq '[TCR] ON'
        End

        It 'it writes important information to the lock file'
            When call tcr 'enable'
            The variable TCR_TEST_FILE_SET_CONTENT_PATH should eq '/current/work/directory/.tcr.lock'
            The variable TCR_TEST_FILE_SET_CONTENT should eq "TCR_HOME=\"$TCR_HOME\""
        End

        Describe 'when enabling tcr mode again'
            It 'should raise an error'
                unset TCR_OUTPUT_SILENT
                tcr 'enable'

                When call tcr 'enable'
                The error should eq "$(error_message "$TCR_ERROR_TCR_ALREADY_ENABLED")"
                The variable TCR_TEST_EXIT_STATUS should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End
End