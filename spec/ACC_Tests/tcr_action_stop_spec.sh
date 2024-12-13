#!/bin/bash

TCR_WORK_DIRECTORY='./spec/tmp'

source './tcr'

Describe 'Acceptance tests'

    Include './spec/test_doubles/time_dummy.sh'

    subject() {
        tcr stop
    }

    Context 'When tcr is enabled'
        Context 'With session name'
            BeforeEach "tcr start 'my cool session'"

            Context 'When tcr gets disabled'
                It 'It tells the named session has ended'

                    When call subject
                    The output should include "[$TEST_TIME] TCR Session 'my cool session' stopped."
                End
            End
        End
    End
End