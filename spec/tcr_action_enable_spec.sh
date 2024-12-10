#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr enable'

    setup() {
        export TCR_OUTPUT_SILENT='true'
        setup_file_mock
    }
    teardown() {
        setup_file_mock
        unset TCR_OUTPUT_SILENT
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

    subject() {
        tcr start "$1"
    }

    Describe 'when enabling tcr mode'
        It 'should creates a tcr lock file at the current work directory'
            When call subject
            The variable TCR_TEST_FILE_CREATE_PATH should eq '/current/work/directory/.tcr.lock'
        End
        
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call subject
            The output should eq '[TCR] session started'
        End

        It 'it writes important information to the lock file'
            When call subject
            The variable TCR_TEST_FILE_SET_CONTENT_PATH should eq '/current/work/directory/.tcr.lock'
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_HOME=\"$TCR_HOME\""
        End

        Context 'When enabling tcr with session name'

            It 'It tells the session with name is started'
                unset TCR_OUTPUT_SILENT

                When call subject 'my cool session'
                The output should eq "[TCR] session 'my cool session' started"
            End

            It 'It writes the session name to the lock file'
                When call subject 'my cool session'
                The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_SESSION_NAME=\"my cool session\""
            End
        End

        Describe 'when enabling tcr mode again'
            BeforeEach 'unset TCR_OUTPUT_SILENT; subject'

            It 'should raise an error'
                When call subject
                The error should eq "$(error_message "$TCR_ERROR_TCR_ALREADY_ENABLED")"
                The status should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End
End