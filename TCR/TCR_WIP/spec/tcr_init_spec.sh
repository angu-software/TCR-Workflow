#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr init'

    setup() {
        print_set_quiet
        setup_exit_mock
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
            The output should eq '[TCR] Generating template configuration 'tcr.tcrcfg''
        End

        It 'It writes config template content to the config file'
            When call tcr init
            The variable TCR_TEST_FILE_SET_CONTENT_PATH should eq '/current/work/directory/tcr.tcrcfg'
            The variable TCR_TEST_FILE_SET_CONTENT should eq "$(cat <<-CONFIG
# TCR Configuration File
# TCR version: 0.1.0

# Build command
TCR_BUILD_CMD=''

# Test command
TCR_TEST_CMD=''

# Commit command
TCR_COMMIT_CMD='git add . && git commit -m "[TCR] Changes working"'

# Revert command
TCR_REVERT_CMD='git checkout --'

CONFIG
)"
        End

        Context 'When config file already exists'
            It 'It raises an error'
                TEST_CFG_EXISTS='true'
                print_unset_quiet
            
                When call tcr init
                The error should eq '[TCR Error] Config file already exists'
                The variable TCR_TEST_EXIT_STATUS should eq 10
            End
        End
    End
End