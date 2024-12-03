#!/bin/bash

source './tcr'

Describe 'tcr'

    Context 'tcr --help'
        It 'should show the help message'
            When call tcr '--help'
            The output should include 'Usage:'
            The output should include 'Actions:'
        End
    End
End