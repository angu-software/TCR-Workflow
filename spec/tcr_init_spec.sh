#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr init'

    Include './spec/test_doubles/time_dummy.sh'

    setup() {
        print_set_quiet
        setup_file_mock
        unset TEST_CFG_EXISTS
    }
    BeforeEach 'setup'

    TEST_CFG_EXISTS=''
    config_file_exists_in_dir() {
        is_set "$TEST_CFG_EXISTS"
    }

    Context 'When executing tcr with init action'
        It 'It creates a template config in the working directory'
            When call tcr init
            The variable TCR_TEST_FILE_CREATE_PATH should eq '/current/work/directory/tcr.tcrcfg'
        End

        It 'It tells that it creates an cfg template'
            print_unset_quiet

            When call tcr init
            The output should eq "$(cat <<-OUTPUT
[$TEST_TIME] Generating template configuration tcr.tcrcfg...
[$TEST_TIME] Generating template completed.
OUTPUT
)"
        End

        It 'It writes config template content to the config file'
            When call tcr init
            The variable TCR_TEST_FILE_SET_CONTENT_PATH should eq '/current/work/directory/tcr.tcrcfg'
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR version: $TCR_VERSION"
            The variable TCR_TEST_FILE_SET_CONTENT should include "# TCR_BUILD_CMD=''"
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_TEST_CMD=''"
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_COMMIT_CMD='git add . && git commit -m \"[TCR] Changes working\"'"
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_REVERT_CMD='git reset --hard'"
            The variable TCR_TEST_FILE_SET_CONTENT should include "TCR_CHANGE_DETECTION_CMD='git --no-pager diff HEAD --name-status'"
        End

        Context 'When config file already exists'
            It 'It raises an error'
                TEST_CFG_EXISTS='true'
                print_unset_quiet
            
                When call tcr init
                The error should eq "[$TEST_TIME] Error: Config file already exists!"
                The status should eq 10
            End
        End
    End
End