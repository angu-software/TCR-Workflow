#!/bin/bash

Describe 'tcr run'
    Pending 'Needs implementation'

    Describe 'When executing tcr with run action'
        It 'It runs the build command'
            When call tcr_run
            The output should eq 'Running build command'
        End

        Describe 'When the build command succeeds'
            It 'It runs the test command'
                When call tcr_run
                The output should eq 'Running test command'
            End

            Describe 'When the test command succeeds'
                It 'It commits the changes'
                    When call tcr_run
                    The output should eq 'Committing changes'
                End

                It 'It plays the success sound'
                    When call tcr_run
                    The output should eq 'Playing success sound'
                End
            End

            Describe 'When the test command fails'
                It 'It reverts the changes'
                    When call tcr_run
                    The output should eq 'Reverting changes'
                End

                It 'It plays the failure sound'
                    When call tcr_run
                    The output should eq 'Playing failure sound'
                End
            End
        End

        Describe 'When the build command fails'
            It 'It raises an error'
                When call tcr_run
                The error should eq 'Build command failed'
                The variable TCR_TEST_EXIT_STATUS should eq 1
            End

            It 'It plays the failure sound'
                When call tcr_run
                The output should eq 'Playing failure sound'
            End
        End
    End
End