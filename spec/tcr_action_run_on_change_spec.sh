#!/bin/bash

source "./spec/test_doubles/home_dir_mock.sh"

source "./lib/tcr/actions/tcr_action_run_on_change.sh"

source "./spec/test_doubles/exit_mock.sh"

Describe 'tcr_action_run_on_change'

    Include './spec/test_doubles/time_dummy.sh'

    tcr_action_run() {
        command_run 'echo "tcr_action_run called"'
    }

    TEST_SPY_COMMAND_RETURN_VALUE=''
    TEST_SPY_COMMAND_RUN_FILE_PATH='./spec/tmp/spy_command_run.txt'
    command_run() {
        command="$*"
        echo "$command" >> "$TEST_SPY_COMMAND_RUN_FILE_PATH"

        if is_set "$TEST_SPY_COMMAND_RETURN_VALUE"; then
            echo "$TEST_SPY_COMMAND_RETURN_VALUE"
        fi
    }

    test_spy_command_run_call_log() {
        command="$(<"$TEST_SPY_COMMAND_RUN_FILE_PATH")"

        echo "$command"
    }

    test_spy_command_run_reset() {
        TEST_SPY_COMMAND_RETURN_VALUE=''
        file_remove "$TEST_SPY_COMMAND_RUN_FILE_PATH"
    }

    TEST_CHANGES_CMD='git --no-pager diff HEAD --name-status'
    tcr_load_config() {
        TCR_CHANGE_DETECTION_CMD="$TEST_CHANGES_CMD"
    }

    subject() {
        tcr_action_run_on_change
    }

    AfterEach 'test_spy_command_run_reset'

    It 'It checks if the repo has changes'
        When call subject
        The line 1 of result of function test_spy_command_run_call_log should eq "git --no-pager diff HEAD --name-status"
    End


    Context 'When change detection command is not specified'
        BeforeEach 'unset TEST_CHANGES_CMD'

        It 'It raises an error'
            When call subject
            The error should eq "[$TEST_TIME] Error: Change detection command TCR_CHANGE_DETECTION_CMD not set in configuration file"
            The status should eq 20
        End
    End

    Context 'When there are changes in the repo'
        BeforeEach 'TEST_SPY_COMMAND_RETURN_VALUE="M file.txt"'

        It 'It tells that changes were detected and the tcr actions are executed'
            When call subject
            The line 1 of output should eq '[TCR] Changes detected'
            The line 3 of output should eq '[TCR] -- Executing TCR actions --'
            The line 4 of output should eq 'M file.txt'
            The line 5 of output should eq '[TCR] -- TCR actions finished --'
        End

        It 'It runs the build and test commands'
            When call subject
            The line 3 of result of function test_spy_command_run_call_log should include 'echo "tcr_action_run called"'
        End
    End
End