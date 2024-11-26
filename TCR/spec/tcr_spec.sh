#!/bin/bash

# -- path.sh --

path_join() {
    local delimiter='/'
    local result="$1"
    shift
    for part in "$@"; do
        result="$result$delimiter$part"
    done
    echo "$result"
}

# -- print.sh --

# set TCR_OUTPUT_SILENT to silence the output
# usually used for testing

print() {
    if [ -n "$TCR_OUTPUT_SILENT" ]; then
        return
    fi
    
    echo "$1"
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

# -- tcr.sh --

TCR_WORK_DIRECTORY="$(pwd)"

tcr() {
    if [ "$1" = 'enable' ]; then
        create_lock_file
        print '[TCR] ON'
        return
    fi

    if [ "$1" = 'disable' ]; then
        remove_lock_file
        print '[TCR] OFF'
        return
    fi
}

# -- Tests --

Describe 'tcr'
    expected_lock_file_path=''
    deleted_file_command=''

    setup() {
        export TCR_OUTPUT_SILENT='true'
    }
    teardown() {
        unset TCR_OUTPUT_SILENT
    }
    BeforeEach 'setup'
    AfterEach 'teardown'

# -- Mocks --

    TCR_WORK_DIRECTORY='/current/work/directory'

    touch() {
        expected_lock_file_path="$1"
    }

    rm() {
        deleted_file_command="rm $1 $2"
    }

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
    End

    Describe 'when disabling tcr mode'
        It 'should delete the tcr lock file'
            When call tcr 'disable'
            The variable deleted_file_command should eq 'rm -f /current/work/directory/.tcr.lock'
        End

        It 'should inform that tcr mode is disabled'
            unset TCR_OUTPUT_SILENT

            When call tcr 'disable'
            The output should eq '[TCR] OFF'
        End
    End
End