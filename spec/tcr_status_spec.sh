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

    subject() {
        tcr status
    }

    Context 'When tcr is specified without session name'
        Context 'When tcr is enabled'
            It 'should inform that tcr mode is enabled'
                When call subject
                The output should eq '[TCR] session active'
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

    Context 'When tcr is specified with session name'
        BeforeEach 'TEST_TCR_ENABLED="true"; TCR_SESSION_NAME="my cool session"'
        AfterEach 'unset TEST_TCR_ENABLED'

        Context 'When tcr is started'
            It 'It tells the name of the session'
                When call subject
                The output should eq "[TCR] session 'my cool session' active"
            End
        End
    End
End