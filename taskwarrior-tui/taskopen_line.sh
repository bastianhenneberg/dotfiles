#!/bin/bash
# Capture the current session name
current_session=$(tmux display-message -p '#S')

# Sleep for a bit to allow tui to load
sleep 0.1

# Extracting the line number and file path from the input string
LINE_NUMBER=$(echo "$1" | awk -F ':' '{print $2}')
FILE_PATH=$(echo "$1" | awk -F ':' '{print $3}')

# Use all arguments beyond the first one as the TASK_DESCRIPTION
shift
TASK_DESCRIPTION="$@"

# If a task description is provided, search for the line number containing that description
if [ ! -z "$TASK_DESCRIPTION" ]; then
	NEW_LINE_NUMBER=$(grep -n -F "$TASK_DESCRIPTION" "$FILE_PATH" | awk -F ':' '{print $1}' | head -n 1)
	if [ ! -z "$NEW_LINE_NUMBER" ]; then
		LINE_NUMBER=$NEW_LINE_NUMBER
	fi
fi

# Capture the file name from the file path without the extension
FILE_NAME=$(basename "$FILE_PATH" | awk -F '.' '{print $1}')
DIR_NAME=$(dirname "$FILE_PATH")

# Create a new tmux session which opens the file with neovim at the specific line number and highlighting it
nvim +$LINE_NUMBER $FILE_PATH


