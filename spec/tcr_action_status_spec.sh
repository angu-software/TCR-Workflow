#!/bin/bash

test_make_status() {
    cat <<-STATUS
TCR Status: $1
--------------------------------------------------
Session Name: $2
Monitoring for Changes: $3
STATUS
}

Describe 'tcr status'
    Include './tcr'

    TEST_TCR_ENABLED='true'
    tcr_is_enabled() {
        is_set "$TEST_TCR_ENABLED"
    }

    tcr_load_session_info() {
        return 0
    }

    tcr_action_watch_is_running() {
        is_set "$TEST_TCR_WATCHING_FOR_CHANGES"
    }

    subject() {
        tcr status
    }

    AfterEach 'unset TEST_TCR_ENABLED'

    Context 'When tcr was started without session name'
        It 'should inform that tcr mode is enabled'
            When call subject
            The output should eq "$(test_make_status 'Active' 'None' 'No')"
        End
    End

    Context 'When tcr was started with session name'
        BeforeEach 'TCR_SESSION_NAME="my cool session"'

        It 'It tells the name of the session'
            When call subject
            The output should eq "$(test_make_status 'Active' 'my cool session' 'No')"
        End
    End

    Context 'When tcr is watching for changes'
        BeforeEach 'TEST_TCR_WATCHING_FOR_CHANGES=true'
        It 'It informs that tcr is watching for changes'
            When call subject
            The output should eq "$(test_make_status 'Active' 'None' 'Yes')"
        End
    End

    Context 'When tcr is disabled'
        BeforeEach 'unset TEST_TCR_ENABLED'

        It 'should inform that tcr mode is disabled'
            When call subject
            The output should eq "$(test_make_status 'Inactive' 'None' 'No')"
        End
    End
End