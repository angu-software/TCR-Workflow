#!/bin/bash

# create watch lock file
# when deleting the watch lock file, tcr watch stops
# exec tcr run when changes in git repo
# clean up when process is canceled (cmd+c)
# status tells if watch is running

# tcr_spec
# evaluate tcr_action_watch is called

source './spec/test_doubles/home_dir_mock.sh'
source './lib/foundation.sh'

source './lib/tcr/actions/tcr_action_watch.sh'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr_action_watch'

    TEST_TCR_ENABLED='true'
    tcr_is_enabled() {
        is_set "$TEST_TCR_ENABLED"
    }

    Context 'When tcr is disabled'
        BeforeAll 'unset TEST_TCR_ENABLED'

        It 'It raises an error'
            When call tcr_action_watch
            The error should eq "$(error_message "$TCR_ERROR_TCR_NOT_ENABLED")"
            The variable TCR_TEST_EXIT_STATUS should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
            The status should eq "$(error_code "$TCR_ERROR_TCR_NOT_ENABLED")"
        End
    End

    Context 'When executing watch action'

        It 'It creates a lock file in the home directory'
            When call tcr_action_watch
            The variable TCR_TEST_FILE_CREATE_PATH should eq "$TCR_ACTION_LOCK_FILE_PATH"
        End
    End
End