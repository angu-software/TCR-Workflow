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

    Context 'When executing tcr with init action'
        It 'It creates a template config in the working directory'
            When call tcr init
            The variable TCR_TEST_FILE_CREATE_PATH should eq '/current/work/directory/tcr.tcrcfg'
        End
    End
End