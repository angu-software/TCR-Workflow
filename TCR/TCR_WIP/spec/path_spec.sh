#!/bin/bash#

source './lib/path.sh'

Describe 'path'
    Describe 'path_join'
        It 'should join the paths with a delimiter'
            When call path_join '/path/to' 'some' 'file'
            The output should eq '/path/to/some/file'
        End
    End
End