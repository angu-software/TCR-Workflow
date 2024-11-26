#!/bin/bash

# -- path.sh --

path_join() {
    local delimiter='/'
    local result="$1"
    shift
    for part in "$@"; do
        result="${result}${delimiter}${part}"
    done
    
    echo "$result"
}

# -- path_spec.sh --

Describe 'path'
    Describe 'path_join'
        It 'should join the paths with a delimiter'
            When call path_join '/path/to' 'some' 'file'
            The output should eq '/path/to/some/file'
        End
    End
End

# -- print.sh --

# set TCR_OUTPUT_SILENT to silence the output
# usually used for testing

TCR_OUTPUT_STDOUT='>&1'
TCR_OUTPUT_STDERR='>&2'

print() {
    local message="$1"
    local output="${2:-$TCR_OUTPUT_STDOUT}"

    if [ -n "$TCR_OUTPUT_SILENT" ]; then
        return
    fi
    
    if [ "$output" == "$TCR_OUTPUT_STDOUT" ]; then
        echo "$message" >&1
    elif [ "$output" == "$TCR_OUTPUT_STDERR" ]; then
        echo "$message" >&2
    fi
}

# -- lock_file.sh --

TCR_LOCK_FILE_NAME='.tcr.lock'

current_lock_file_path() {
    path_join "$TCR_WORK_DIRECTORY" "$TCR_LOCK_FILE_NAME"
}

create_lock_file() {
    touch "$(current_lock_file_path)"
}

remove_lock_file() {
    rm -f "$(current_lock_file_path)"
}

# -- error_const.sh --

# Error format: "<error_code>|<error_message>"

TCR_ERROR_TCR_ALREADY_ENABLED='1|[TCR] TCR is already enabled'

# -- error.sh --

source './lib/error.sh'

# -- exit_mock.sh --

source './spec/exit_mock.sh'

# -- error_spec.sh --

Describe 'error'
    setup_exit_mock

    BeforeEach 'unset TCR_TEST_EXIT_STATUS'

    ERROR="1|Some strange error"

    Describe 'error_message'
        It 'should return the error message from an error'
            When call error_message "$ERROR"
            The output should eq 'Some strange error'
        End
    End

    Describe 'error_code'
        It 'should return the error code from an error'
            When call error_code "$ERROR"
            The output should eq '1'
        End
    End

    Describe 'raise_error'
        It 'should print the error message to stderr'
            When call raise_error "$ERROR"
            The error should eq 'Some strange error'
            The variable "$TCR_TEST_EXIT_STATUS" should eq 1
        End
    End
End

# -- Tests --

Describe 'tcr'
    source './tcr'

    setup() {
        export TCR_OUTPUT_SILENT='true'
    }
    teardown() {
        unset expected_lock_file_path
        unset deleted_file_command
        unset TCR_OUTPUT_SILENT
        unset TCR_TEST_EXIT_STATUS
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

# -- Mocks --

    TCR_WORK_DIRECTORY='/current/work/directory'

    touch() {
        expected_lock_file_path="$1"
    }

    rm() {
        deleted_file_command="_rm_ $1 $2"
    }

    setup_exit_mock

# -- Examples --

    Describe 'when enabling tcr mode'
        It 'should creates a tcr lock file at the current work directory'
            When call tcr 'enable'
            The variable expected_lock_file_path should eq '/current/work/directory/.tcr.lock'
        End
        
        It 'should inform that tcr mode is enabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'enable'
            The output should eq '[TCR] ON'
        End

        Describe 'when enabling tcr mode again'
            tcr 'enable'

            It 'should raise an error'
                unset TCR_OUTPUT_SILENT

                When call tcr 'enable'
                The error should eq "$(error_message "$TCR_ERROR_TCR_ALREADY_ENABLED")"
                The variable "$TCR_TEST_EXIT_STATUS" should eq "$(error_code "$TCR_ERROR_TCR_ALREADY_ENABLED")"
            End
        End
    End

    Describe 'when disabling tcr mode'
        It 'should delete the tcr lock file'
            When call tcr 'disable'
            The variable deleted_file_command should eq '_rm_ -f /current/work/directory/.tcr.lock'
        End

        It 'should inform that tcr mode is disabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'disable'
            The output should eq '[TCR] OFF'
        End
    End
End