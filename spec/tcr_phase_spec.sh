#!/bin/bash

TCR_HOME="./"

Describe 'tcr_phase.sh'
    Include lib/tcr/tcr_phase.sh

    Include spec/test_doubles/time_dummy.sh

    test_dummy_command() {
        cat <<-COMMAND_OUTPUT
Running 10 tests...
Test 1: Passed
Test 2: Passed
...
Test 10: Passed
COMMAND_OUTPUT

        return "$TEST_COMMAND_RETURN_CODE"
    }

    TEST_PHASE="testing|Test|Running tests...|All tests passed.|Tests are failing."
    TEST_COMMAND_RETURN_CODE=0
    TEST_COMMAND="test_dummy_command"

    subject() {
        tcr_phase_exec "$TEST_PHASE" "$TEST_COMMAND"
    }

    Describe 'tcr_phase'
        BeforeEach 'TEST_COMMAND_RETURN_CODE=0'

        It 'It tells the phase is executing'
            When call subject
            The error should be blank
            The output should eq "$(cat <<-OUTPUT
[$TEST_TIME] Running tests...
[Test Output]
--------------------------------------------------
Running 10 tests...
Test 1: Passed
Test 2: Passed
...
Test 10: Passed
--------------------------------------------------
[$TEST_TIME] All tests passed.
OUTPUT
)"
        End

        Context 'When the phase fails'
            BeforeEach 'TEST_COMMAND_RETURN_CODE=1'

            It 'It tells the phase was failing'
                When call subject
                The error should be blank
                The status should be failure
                The line 10 of output should eq "[$TEST_TIME] Tests are failing."
            End

            It 'It returns the commands exit code'
                When call subject
                The output should be present
                The status should eq "$TEST_COMMAND_RETURN_CODE"
            End
        End
    End
End