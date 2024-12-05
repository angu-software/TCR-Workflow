#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr disable'

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

    Describe 'when disabling tcr mode'
        BeforeEach 'tcr enable'

        It 'should delete the tcr lock file'
            When call tcr 'disable'
            The variable TCR_TEST_FILE_DELETE_CMD should eq '_rm_ -f /current/work/directory/.tcr.lock'
        End

        It 'should inform that tcr mode is disabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'disable'
            The output should eq '[TCR] OFF'
        End
    End
End