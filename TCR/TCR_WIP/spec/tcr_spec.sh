#!/bin/bash

# -- path.sh --

source './lib/path.sh'

# -- print.sh --

source './lib/print.sh'

# -- lock_file.sh --

source './lib/lock_file.sh'

# -- error_const.sh --

source './lib/error_const.sh'

# -- error.sh --

source './lib/error.sh'

# -- exit_mock.sh --

source './spec/exit_mock.sh'

# -- Tests --

Describe 'tcr'
    source './tcr'

    setup() {
        export TCR_OUTPUT_SILENT='true'
    }
    teardown() {
        unset expected_lock_file_path
        unset deleted_file_command
        unset TCR_OUTPUT_SILENT
        unset TCR_TEST_EXIT_STATUS
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

# -- Mocks --

    TCR_WORK_DIRECTORY='/current/work/directory'

    touch() {
        expected_lock_file_path="$1"
    }

    rm() {
        deleted_file_command="_rm_ $1 $2"
    }

    setup_exit_mock

# -- Examples --

    Describe 'when enabling tcr mode'
        It 'should creates a tcr lock file at the current work directory'
            When call tcr 'enable'
            The variable expected_lock_file_path should eq '/current/work/directory/.tcr.lock'
        End
        
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'enable'
            The output should eq '[TCR] ON'
        End

        Describe 'when enabling tcr mode again'
            tcr 'enable'

            It 'should raise an error'
                unset TCR_OUTPUT_SILENT

                When call tcr 'enable'
                The error should eq "$(error_message "$TCR_ERROR_TCR_ALREADY_ENABLED")"
                The variable "$TCR_TEST_EXIT_STATUS" should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End

    Describe 'when disabling tcr mode'
        It 'should delete the tcr lock file'
            When call tcr 'disable'
            The variable deleted_file_command should eq '_rm_ -f /current/work/directory/.tcr.lock'
        End

        It 'should inform that tcr mode is disabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'disable'
            The output should eq '[TCR] OFF'
        End
    End
End