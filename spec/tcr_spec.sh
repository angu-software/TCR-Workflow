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

    Context 'tcr --version'
        It 'should show the version'
            When call tcr '--version'
            The output should eq "[TCR] v$TCR_VERSION"
        End
    End
End