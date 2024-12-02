#!/bin/bash

source './spec/test_doubles/home_dir_mock.sh'

source './lib/tcr/config_file.sh'

source './spec/test_doubles/file_mock.sh'

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