#!/bin/bash

Describe 'tcr_foundation'

    source "./spec/test_doubles/home_dir_mock.sh"
    source "./spec/test_doubles/work_dir_mock.sh"

    source "./lib/tcr/tcr_foundation.sh"

    source "./spec/test_doubles/exit_mock.sh"
    source "./spec/test_doubles/test_stub_find.sh"

    Include './spec/test_doubles/time_dummy.sh'

    Describe 'tcr_load_config'

        TEST_LOADED_FILE_PATH=''
        file_load_as_source() {
            TEST_LOADED_FILE_PATH="$1"
        }

        subject() {
            tcr_load_config
        }

        AfterEach 'test_stub_reset'

        It 'It searches for a tcr configuration file in the current work directory'
            When call subject
            The result of function test_stub_find_call_log should include "$TCR_WORK_DIRECTORY"
        End

        Context 'When cfg file is found'
            BeforeEach "TEST_STUB_FIND_RESULT_FILE_PATH='./spec/fixtures/config_fixture.tcrcfg'"
                        
            It 'It loads the configuration file'
                When call subject
                The variable TEST_LOADED_FILE_PATH should eq "$TEST_STUB_FIND_RESULT_FILE_PATH"
            End
        End

        Context 'When no cfg file is found'
            It 'It raises an error'
                unset TEST_STUB_FIND_RESULT_FILE_PATH
                    
                When call subject
                The error should eq "[$TEST_TIME] Error: No configuration file found!"
                The status should eq 5
            End
        End
    End
End