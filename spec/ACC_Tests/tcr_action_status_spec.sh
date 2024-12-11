#!/bin/bash

TCR_WORK_DIRECTORY='./spec/tmp'

source './tcr'

Describe 'Acceptance tests'

    subject() {
        tcr status
    }

    Context 'When tcr gets enabled'
        Context 'With session name'
            BeforeEach "tcr start 'my cool session'"
            AfterEach 'tcr stop'

            It 'It shows the session name in the status'
                When call subject
                The output should eq "[TCR] session 'my cool session' active"
            End
        End
    End
End