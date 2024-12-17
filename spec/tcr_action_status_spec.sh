#!/bin/bash

test_make_status() {
    cat <<-STATUS
TCR Status: $1
--------------------------------------------------
Started: $2
Session Name: $3
Monitoring for Changes: $4
STATUS
}

Describe 'tcr status'
    Include './spec/test_doubles/home_dir_mock.sh'

    Include './lib/tcr/actions/tcr_action_status.sh'

    Include './spec/test_doubles/date_time_dummy.sh'

    TEST_TCR_ENABLED='true'
    tcr_is_enabled() {
        is_set "$TEST_TCR_ENABLED"
    }

    TEST_SESSION_NAME=''
    tcr_load_session_info() {
        TCR_SESSION_NAME="$TEST_SESSION_NAME"
        TCR_SESSION_START_DATE_TIME="$TEST_DATE_TIME"
        return 0
    }

    tcr_action_watch_is_running() {
        is_set "$TEST_TCR_WATCHING_FOR_CHANGES"
    }

    subject() {
        tcr_action_status
    }

    AfterEach 'unset TEST_TCR_ENABLED; unset TEST_SESSION_NAME; unset TEST_TCR_WATCHING_FOR_CHANGES'

    Context 'When tcr was started without session name'

        It 'should inform that tcr mode is enabled'
            When call subject
            The output should eq "$(test_make_status 'Active' "$TEST_DATE_TIME" 'None' 'No')"
        End
    End

    Context 'When tcr was started with session name'

        BeforeEach 'TEST_SESSION_NAME="my cool session"'

        It 'It tells the name of the session'
            When call subject
            The output should eq "$(test_make_status 'Active' "$TEST_DATE_TIME" 'my cool session' 'No')"
        End
    End

    Context 'When tcr is watching for changes'

        BeforeEach 'TEST_TCR_WATCHING_FOR_CHANGES=true'
        It 'It informs that tcr is watching for changes'
            When call subject
            The output should eq "$(test_make_status 'Active' "$TEST_DATE_TIME" 'None' 'Yes')"
        End
    End

    Context 'When tcr is disabled'
        BeforeEach 'unset TEST_TCR_ENABLED'

        It 'should inform that tcr mode is disabled'
            When call subject
            The output should eq "$(test_make_status 'Inactive' "Never" 'None' 'No')"
        End
    End
End