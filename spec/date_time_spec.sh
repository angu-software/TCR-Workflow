#!/bin/bash

Describe 'time.sh'
    Include lib/date_time.sh

    Describe 'time_now'

        subject() {
            time_now
        }

        It 'It returns the current time'
            When call subject
            The output should eq "$(date +"%H:%M:%S")"
        End
    End
End