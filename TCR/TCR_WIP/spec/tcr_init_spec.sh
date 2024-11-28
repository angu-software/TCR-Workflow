#!/bin/bash

source './spec/test_doubles/work_dir_mock.sh'

source './tcr'

source './spec/test_doubles/file_mock.sh'

Describe 'tcr init'

    setup() {
        setup_file_mock
    }
    teardown() {
        setup_file_mock
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

    find() {
        parameters="$*"
        TEST_FILE_SEARCH_COMMAND="_find_ $parameters"
    }

    Context 'When executing tcr with init action'
        It 'It creates a template config in the working directory'
            When call tcr init
            The variable TCR_TEST_FILE_CREATE_PATH should eq '/current/work/directory/tcr.tcrcfg'
        End

        It 'It searches for an existing config file'
            When call tcr init
            The variable TEST_FILE_SEARCH_COMMAND should eq '_find_ /current/work/directory -maxdepth 1 -type f -name "*.tcrcfg"'
        End

        Context 'When config file already exists'
            Pending

            It 'It raises an error'
                When call tcr init
                The error should eq '[TCR Error] Config file already exists'
            End
        End
    End
End