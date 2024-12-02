#!/bin/bash
set -e

install_tool() {
    local TOOL_NAME=$1
    local TOOL_VERSION=$2
    local TOOL_ARCHIVE=$3
    local TOOL_URL=$4

    # Check if all parameters are set
    if [[ -z "$TOOL_NAME" || -z "$TOOL_VERSION" || -z "$TOOL_ARCHIVE" || -z "$TOOL_URL" ]]; then
        echo "Error: Missing parameters. TOOL_NAME, TOOL_VERSION, TOOL_ARCHIVE, and TOOL_URL must all be set."
        return 1
    fi

    echo "Installing ${TOOL_NAME} ${TOOL_VERSION}..."

    # Download tools
    curl -L -o ${DOWNLOAD_DIR}/${TOOL_ARCHIVE} ${TOOL_URL}

    # Unzip tools based on the archive extension
    case "${TOOL_ARCHIVE}" in
        *.zip)
            unzip -o ${DOWNLOAD_DIR}/${TOOL_ARCHIVE} -d ${TOOLS_BIN_DIR}
            ;;
        *.tar.gz)
            tar -xzf ${DOWNLOAD_DIR}/${TOOL_ARCHIVE} -C ${TOOLS_BIN_DIR}
            ;;
        *)
            echo "Error: Unsupported archive format for ${TOOL_ARCHIVE}"
            return 1
            ;;
    esac
}

# -- Tools --

SHELL_SPEC_NAME=shellspec
SHELL_SPEC_VERSION=0.28.1
SHELL_SPEC_ARCHIVE=shellspec-dist.tar.gz
SHELL_SPEC_URL="https://github.com/shellspec/shellspec/releases/download/${SHELL_SPEC_VERSION}/${SHELL_SPEC_ARCHIVE}"

# -- Install SwiftLint --

TOOLS_DIR=Tools
DOWNLOAD_DIR=$TOOLS_DIR/__tmp__
TOOLS_BIN_DIR=$TOOLS_DIR/bin

# Create directories
mkdir -p $DOWNLOAD_DIR

install_tool $SHELL_SPEC_NAME $SHELL_SPEC_VERSION $SHELL_SPEC_ARCHIVE $SHELL_SPEC_URL

# Clean up
rm -rf $DOWNLOAD_DIR
