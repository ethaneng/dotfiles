#!/bin/bash

# Helper script to notify sketchybar of workspace changes
# Usage: notify_workspace_change.sh <workspace_number>
# If no workspace number is provided, it will query hyprspace for the current workspace

WORKSPACE="$1"

# If no workspace provided, get current focused workspace
if [ -z "$WORKSPACE" ]; then
    WORKSPACE=$(hyprspace list-workspaces --focused)
fi

# Small delay to ensure workspace switch completes
sleep 0.05

# Notify sketchybar
sketchybar --trigger aerospace_workspace_change FOCUSED_WORKSPACE="$WORKSPACE"
