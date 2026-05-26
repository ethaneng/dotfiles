#!/usr/bin/env bash

# Rename a project workspace
# Usage: rename_workspace.sh <workspace_label> <new_name>
# Example: rename_workspace.sh p1 "Frontend"
# Example: rename_workspace.sh p3 ""  # Clear name

NAMES_FILE="${HOME}/.config/yabai/workspace_names.json"

# Create default file if missing
if [ ! -f "$NAMES_FILE" ]; then
    cat > "$NAMES_FILE" << 'EOF'
{
  "p1": "",
  "p2": "",
  "p3": "",
  "p4": "",
  "p5": "",
  "p6": "",
  "p7": "",
  "p8": "",
  "p9": "",
  "p10": ""
}
EOF
fi

WORKSPACE_LABEL="$1"
NEW_NAME="$2"

# Validate workspace label (p1-p10)
if [[ ! "$WORKSPACE_LABEL" =~ ^p([1-9]|10)$ ]]; then
    echo "Error: Workspace label must be p1-p10, got: $WORKSPACE_LABEL"
    exit 1
fi

# Update JSON file
jq --arg key "$WORKSPACE_LABEL" --arg name "$NEW_NAME" \
   '.[$key] = $name' "$NAMES_FILE" > "${NAMES_FILE}.tmp" && \
   mv "${NAMES_FILE}.tmp" "$NAMES_FILE"

# Trigger sketchybar refresh
sketchybar --trigger yabai_window_change

# Extract number for display
NUM="${WORKSPACE_LABEL#p}"
if [ -z "$NEW_NAME" ]; then
    echo "Workspace $NUM name cleared"
else
    echo "Workspace $NUM renamed to: $NEW_NAME"
fi
