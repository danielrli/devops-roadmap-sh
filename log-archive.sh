#!/bin/bash

# Prompt User for log directory
#read -r -p "Specify Log Directory: " input
#input="${input:-/var/log}"

# Pass Argument into script
if [ -z "$1" ]; then
    echo "Specify a log directory: log-archive <log-dir>"
    exit 1
fi

input="$1"

if [ ! -d "$input" ]; then
    echo "Error: Log directory does not exist."
    input=""
    exit 1
fi

echo "Log directory set to $input"

archive_directory="$input/archive"
mkdir "$archive_directory"

if ! mkdir -p "$archive_directory"; then
    echo "Error creating $archive_directory."
    exit 1
fi

# Make time stamp and set file name
timestamp=$(date +"%Y%m%d_%H%M%S")
archive_file="$archive_directory/logs_archive_$timestamp.tar.gz"

# Change working directory to $input to flatten
(cd "$input" && tar --exclude="./archive" -czvf "$archive_file" ./*)

echo "Logs archvied at: $archive_file"
