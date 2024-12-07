#!/bin/bash

source './tcr'

Describe 'tcr status'

    TEST_TCR_ENABLED='true'
    tcr_is_enabled() {
        is_set "$TEST_TCR_ENABLED"
    }

    subject() {
        tcr status
    }

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