#!/bin/bash
set -euo pipefail

INPUT=$1
TARGET_DIR="/opt/demo-folder"
TARGET_FILE="$TARGET_DIR/sample.txt"

if [[ "$INPUT" -eq 1 ]]; then
    mkdir -p "$TARGET_DIR"
    echo "File created by cron with input 1" > "$TARGET_FILE"
elif [[ "$INPUT" -eq 0 ]]; then
    rm -rf "$TARGET_DIR"
else
    echo "Invalid input. Use 0 or 1"
    exit 1
fi

