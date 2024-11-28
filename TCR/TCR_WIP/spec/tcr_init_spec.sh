#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/exit_mock.sh'
source './spec/test_doubles/file_mock.sh'

Describe 'tcr init'

    setup() {
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

        Context 'When config file already exists'
            It 'It raises an error'
                TEST_CFG_EXISTS='true'
            
                When call tcr init
                The error should eq '[TCR Error] Config file already exists'
                The variable TCR_TEST_EXIT_STATUS should eq 10
            End
        End
    End
End

# -- config_file.sh -- #

Describe 'config_file'

    find() {
        parameters="$*"

        TEST_FILE_SEARCH_COMMAND="_find_ $parameters"

        echo '/current/work/directory/tcr.tcrcfg'
    }

    Context 'When searhing for a file'
        It 'It searches for file in a directory'
            When call config_file_find_in_dir '/current/work/directory'
            The variable TEST_FILE_SEARCH_COMMAND should eq '_find_ /current/work/directory -maxdepth 1 -type f -name *.tcrcfg'
            The output should eq '/current/work/directory/tcr.tcrcfg'
        End
    End
End