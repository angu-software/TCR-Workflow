#!/bin/bash

source './spec/test_consts.sh'

source './tcr'
TCR_WORK_DIRECTORY='/current/work/directory'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/lock_file_mock.sh'

Describe 'tcr'

    setup() {
        export TCR_OUTPUT_SILENT='true'
        setup_exit_mock
        setup_lock_file_mock
    }
    teardown() {
        setup_exit_mock
        setup_lock_file_mock
        unset TCR_OUTPUT_SILENT
        unset TCR_TEST_EXIT_STATUS
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

# -- Mocks --


# -- Examples --

    Describe 'when enabling tcr mode'
        It 'should creates a tcr lock file at the current work directory'
            When call tcr 'enable'
            The variable TRC_TEST_LOCK_FILE_PATH should eq '/current/work/directory/.tcr.lock'
        End
        
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'enable'
            The output should eq '[TCR] ON'
        End

        Describe 'when enabling tcr mode again'
            It 'should raise an error'
                unset TCR_OUTPUT_SILENT
                tcr 'enable'

                When call tcr 'enable'
                The error should eq "$(error_message "$TCR_ERROR_TCR_ALREADY_ENABLED")"
                The variable "$TCR_TEST_EXIT_STATUS" should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End

    Describe 'when disabling tcr mode'
        It 'should delete the tcr lock file'
            When call tcr 'disable'
            The variable TRC_TEST_LOCK_FILE_DELETE_CMD should eq '_rm_ -f /current/work/directory/.tcr.lock'
        End

        It 'should inform that tcr mode is disabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'disable'
            The output should eq '[TCR] OFF'
        End
    End
End