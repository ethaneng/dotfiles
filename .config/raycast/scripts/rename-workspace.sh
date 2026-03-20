#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rename Current Workspace
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🏷️
# @raycast.packageName Yabai
# @raycast.argument1 { "type": "text", "placeholder": "New name (empty to clear)", "optional": true }

# Get current workspace label
CURRENT=$(yabai -m query --spaces --space | jq -r '.label')

# Only allow renaming project workspaces (p1-p10)
if [[ ! "$CURRENT" =~ ^p[0-9]+$ ]]; then
    echo "Cannot rename fixed workspace: $CURRENT"
    exit 1
fi

# Call the rename helper
~/.config/yabai/helpers/rename_workspace.sh "$CURRENT" "$1"
