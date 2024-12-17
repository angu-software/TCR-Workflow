#!/bin/bash

Describe 'tcr_action_start'
    Include './spec/test_doubles/home_dir_mock.sh'
    Include './spec/test_doubles/work_dir_mock.sh'
    
    Include './lib/tcr/actions/tcr_action_start.sh'

    Include './spec/test_doubles/time_dummy.sh'
    Include './spec/test_doubles/date_time_dummy.sh'
    Include './spec/test_doubles/exit_mock.sh'
    Include './spec/test_doubles/file_mock.sh'

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
        tcr_action_start my cool session
    }

    Describe 'when enabling tcr mode'       
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call subject
            The output should eq "$(cat <<-OUTPUT
[$TEST_TIME] Starting TCR session 'my cool session'...
[$TEST_TIME] TCR session 'my cool session' started.
OUTPUT
)"
        End

        It 'It writes session information to the lock file'
            When call subject
            The variable TCR_TEST_FILE_SET_CONTENT_PATH should eq '/current/work/directory/.tcr.lock'
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_HOME=\"$(path_expand $TCR_HOME)\""
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_SESSION_NAME=\"my cool session\""
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_SESSION_START_DATE_TIME=\"$TEST_DATE_TIME\""
        End

        Describe 'when enabling tcr mode again'
            BeforeEach 'unset TCR_OUTPUT_SILENT; subject'

            It 'should raise an error'
                When call subject
                The error should eq "[$TEST_TIME] Error: TCR is already enabled!"
                The status should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End
End