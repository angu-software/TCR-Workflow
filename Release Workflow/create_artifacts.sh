#!/bin/bash

ARCHIVE_NAME="tcr-workflow"
PROJECT_ROOT="."
FILES=(
    "$PROJECT_ROOT/lib"
    "$PROJECT_ROOT/CHANGELOG.md"
    "$PROJECT_ROOT/install_tcr.sh"
    "$PROJECT_ROOT/LICENSE"
    "$PROJECT_ROOT/README.md"
    "$PROJECT_ROOT/tcr"
    "$PROJECT_ROOT/tcr_version.sh"
    "$PROJECT_ROOT/tcr.env"
    "$PROJECT_ROOT/uninstall_tcr.sh"
    "$PROJECT_ROOT/resources"
)

create_tar() {
    echo "Creating tar archive..."
    tar -czvf "$ARCHIVE_NAME.tar.gz" "${FILES[@]}"
}

create_zip() {
    echo "Creating zip archive..."
    zip -r "$ARCHIVE_NAME.zip" "${FILES[@]}"
}

create_artifacts() {
    create_tar
    create_zip
}

echo "Creating artifacts..."
if create_artifacts; then
    echo "Artifacts have been created successfully!"
else
    echo "Failed to create artifacts!"
fi