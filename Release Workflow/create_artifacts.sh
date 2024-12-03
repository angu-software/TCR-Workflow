#!/bin/bash

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
)

create_artifacts() {
    tar -czvf tcr-workflow.tar.gz "${FILES[@]}"
}

echo "Creating artifacts..."
if create_artifacts; then
    echo "Artifacts have been created successfully!"
else
    echo "Failed to create artifacts!"
fi