#!/bin/bash

TCR_WORK_DIRECTORY='./spec/tmp'

source './tcr'

Describe 'Acceptance tests'

    subject() {
        tcr stop
    }

    Context 'When tcr is enabled'
        Context 'With session name'
            BeforeEach "tcr start 'my cool session'"

            Context 'When tcr gets disabled'
                It 'It tells the named session has ended'
                    When call subject
                    The output should include "[TCR] session 'my cool session' stopped"
                End
            End
        End
    End
End