#!/bin/bash

source './tcr'

Describe 'tcr status'

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
            The output should eq '[TCR] session active'
        End
    End

    Context 'When tcr was started with session name'
        BeforeEach 'TCR_SESSION_NAME="my cool session"'

        It 'It tells the name of the session'
            When call subject
            The output should eq "[TCR] session 'my cool session' active"
        End
    End

    Context 'When tcr is watching for changes'
        BeforeEach 'TEST_TCR_WATCHING_FOR_CHANGES=true'

        It 'It informs that tcr is watching for changes'
            When call subject
            The output should eq "$(cat <<-STATUS_OUTPUT
[TCR] session active
[TCR] watching for changes
STATUS_OUTPUT
)"
        End
    End

    Context 'When tcr is disabled'
        BeforeEach 'unset TEST_TCR_ENABLED'

        It 'should inform that tcr mode is disabled'
            When call subject
            The output should eq '[TCR] no session active'
        End
    End
End