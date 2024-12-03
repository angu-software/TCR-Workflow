#!/bin/bash

source "./tcr"

Describe 'file'

    TEST_PROJECT_ROOT="$SHELLSPEC_PROJECT_ROOT"
    TEST_FILE_PATH=""

    Context 'file_absolute_dir_path'
        Context 'When given a absolute file path'
            TEST_FILE_PATH="$TEST_PROJECT_ROOT/tcr"

            It 'returns the directory path of a file'
                When call file_absolute_dir_path "$TEST_FILE_PATH"
                The output should eq "$TEST_PROJECT_ROOT"
            End
        End

        Context 'When given a relative file path'
            TEST_FILE_PATH="./tcr"

            It 'returns the directory path of a file'
                When call file_absolute_dir_path "$TEST_FILE_PATH"
                The output should eq "$TEST_PROJECT_ROOT"
            End
        End

        Context 'When given a symlink to a file'
            setUp() {
                TEST_FILE_PATH="$TEST_PROJECT_ROOT/tcr"
                TEST_SYMLINK_PATH="$TEST_PROJECT_ROOT/spec/fixtures/tcr_symlink"
                ln -s "$TEST_FILE_PATH" "$TEST_SYMLINK_PATH"
            }
            tearDown() {
                rm "$TEST_SYMLINK_PATH"
            }

            BeforeAll 'setUp'
            AfterAll 'tearDown'

            It 'returns the directory path of a file'
                When call file_absolute_dir_path "$TEST_SYMLINK_PATH"
                The output should eq "$TEST_PROJECT_ROOT"
            End
        End
    End
End