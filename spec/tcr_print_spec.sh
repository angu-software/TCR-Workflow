#!/bin/bash

Describe 'tcr_print.sh'
    Include spec/test_doubles/home_dir_mock.sh
    Include lib/tcr/tcr_print.sh

    time_now() {
        echo "12:34:56"
    }

    Describe 'tcr_print_event'

        subject() {
            tcr_print_event "$*"
        }

        It 'It prints an event with the current time'
            When call subject Starting TCR cycle...
            The output should eq "[12:34:56] Starting TCR cycle..."
        End

        Context 'When no event message is provided'
            It 'It prints nothing'
                When call subject
                The output should be blank
            End
        End
    End

    Describe 'tcr_print_header'

        subject() {
            tcr_print_header "$*"
        }

        It 'It prints a header with the current time'
            When call subject 'Test Output'
            The output should eq "$(cat <<-HEADER
[Test Output]
--------------------------------------------------
HEADER
)"
        End

        Context 'When no title is provided'
            It 'It prints nothing'
                When call subject
                The output should be blank
            End
        End
    End

    Describe 'tcr_print_footer_event'

        subject() {
            tcr_print_footer_event "$*"
        }

        It 'It prints a separator'
            When call subject All tests passed.
            The output should eq "$(cat <<-HEADER
--------------------------------------------------
[12:34:56] All tests passed.
HEADER
)"
        End

        Context 'When no event message is provided'
            It 'It prints nothing'
                When call subject
                The output should be blank
            End
        End
    End
End