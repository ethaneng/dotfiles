#!/usr/bin/env bash

# Ensure exactly 15 labeled spaces exist:
# - Spaces 1-10: Project workspaces (p1-p10)
# - Spaces 11-15: Fixed workspaces (y,u,i,o,p)

PROJECT_LABELS=("p1" "p2" "p3" "p4" "p5" "p6" "p7" "p8" "p9" "p10")
FIXED_LABELS=("y" "u" "i" "o" "p")
TOTAL_SPACES=15

# Create workspace names file if missing
NAMES_FILE="${HOME}/.config/yabai/workspace_names.json"
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

# Prevent multiple concurrent executions
LOCKFILE="/tmp/yabai_ensure_spaces.lock"
if [ -f "$LOCKFILE" ]; then
    echo "Another instance is running, exiting..."
    exit 0
fi
touch "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT

# Get all current spaces
SPACES=$(yabai -m query --spaces)
SPACE_COUNT=$(echo "$SPACES" | jq '. | length')

echo "Current space count: $SPACE_COUNT"

# Create additional spaces if needed
if [ "$SPACE_COUNT" -lt "$TOTAL_SPACES" ]; then
    SPACES_TO_CREATE=$((TOTAL_SPACES - SPACE_COUNT))
    echo "Creating $SPACES_TO_CREATE additional spaces..."

    for _ in $(seq 1 $SPACES_TO_CREATE); do
        yabai -m space --create
    done

    # Requery after creation
    SPACES=$(yabai -m query --spaces)
    SPACE_COUNT=$(echo "$SPACES" | jq '. | length')
fi

# Label project workspaces (spaces 1-10)
echo "Labeling project workspaces 1-10..."
for i in {1..10}; do
    LABEL="${PROJECT_LABELS[$((i-1))]}"
    yabai -m space $i --label "$LABEL" 2>/dev/null
    echo "Space $i -> $LABEL"
done

# Label fixed workspaces (spaces 11-15)
echo "Labeling fixed workspaces 11-15..."
for i in {11..15}; do
    LABEL="${FIXED_LABELS[$((i-11))]}"
    yabai -m space $i --label "$LABEL" 2>/dev/null
    echo "Space $i -> $LABEL"
done

# Handle extra spaces (beyond 15)
if [ "$SPACE_COUNT" -gt "$TOTAL_SPACES" ]; then
    echo "Found $((SPACE_COUNT - TOTAL_SPACES)) extra space(s) beyond index $TOTAL_SPACES"

    # Process extra spaces in reverse order
    for ((i=SPACE_COUNT; i>TOTAL_SPACES; i--)); do
        SPACE_INFO=$(echo "$SPACES" | jq -r ".[] | select(.index == $i)")
        SPACE_LABEL=$(echo "$SPACE_INFO" | jq -r '.label')

        echo "Processing space $i (label: '$SPACE_LABEL')..."

        # Get windows in this space
        WINDOWS=$(yabai -m query --windows --space $i 2>/dev/null | jq -r '.[].id' 2>/dev/null)

        if [ -n "$WINDOWS" ]; then
            echo "  Moving windows from space $i to space 1..."
            for WINDOW_ID in $WINDOWS; do
                yabai -m window $WINDOW_ID --space 1 2>/dev/null && echo "    Moved window $WINDOW_ID"
            done
        fi

        # Try to destroy the space
        echo "  Attempting to destroy space $i..."
        yabai -m space --focus $i 2>/dev/null
        if yabai -m space --destroy 2>/dev/null; then
            echo "  Destroyed space $i"
        else
            echo "  Could not destroy space $i (macOS may recreate it automatically)"
        fi
    done
fi

echo "Space setup complete!"
echo ""
yabai -m query --spaces | jq -r '.[] | "Space \(.index) (\(.label)): \(.windows | length) window(s)"'
