#!/bin/bash

# Pseudo-fullscreen toggle for HyprSpace
# Creates a centered floating window at 16:9 ratio with margins
# Works with monocle blur effect for aesthetic appeal

# Configuration
MARGIN_ALL_SIDES=80  # Minimum margin from all edges (pixels)
STATE_FILE="/tmp/hyprspace_pseudo_fullscreen_state"
WINDOW_RATIO=1.777777778  # 16:9 aspect ratio (16/9)

# Get focused window ID
FOCUSED_WINDOW=$(hyprspace list-windows --focused --format '%{window-id}' 2>/dev/null)

if [ -z "$FOCUSED_WINDOW" ]; then
    echo "No focused window found"
    exit 1
fi

# Check if we're currently in pseudo-fullscreen mode
if [ -f "$STATE_FILE" ] && grep -q "$FOCUSED_WINDOW" "$STATE_FILE"; then
    # Exit pseudo-fullscreen: return to tiling
    hyprspace layout tiling
    sed -i '' "/$FOCUSED_WINDOW/d" "$STATE_FILE"
    echo "Exited pseudo-fullscreen mode"
else
    # Enter pseudo-fullscreen: make floating and center with margins

    # Get monitor dimensions using system_profiler and display info
    # This gets the actual screen resolution
    SCREEN_RES=$(system_profiler SPDisplaysDataType | grep Resolution | head -1 | awk '{print $2, $4}')
    MONITOR_WIDTH=$(echo "$SCREEN_RES" | awk '{print $1}')
    MONITOR_HEIGHT=$(echo "$SCREEN_RES" | awk '{print $2}')

    echo "Monitor dimensions: ${MONITOR_WIDTH}x${MONITOR_HEIGHT}"

    # Calculate window dimensions maintaining 16:9 ratio
    # Try to maximize width first
    MAX_WIDTH=$((MONITOR_WIDTH - (MARGIN_ALL_SIDES * 2)))
    MAX_HEIGHT=$((MONITOR_HEIGHT - (MARGIN_ALL_SIDES * 2)))

    # Calculate height based on width with 16:9 ratio (use awk for proper integer output)
    CALCULATED_HEIGHT=$(awk "BEGIN {printf \"%.0f\", $MAX_WIDTH / $WINDOW_RATIO}")

    if [ "$CALCULATED_HEIGHT" -gt "$MAX_HEIGHT" ]; then
        # Height would be too large, constrain by height instead
        WINDOW_HEIGHT=$MAX_HEIGHT
        WINDOW_WIDTH=$(awk "BEGIN {printf \"%.0f\", $WINDOW_HEIGHT * $WINDOW_RATIO}")
    else
        # Width constraint works
        WINDOW_WIDTH=$MAX_WIDTH
        WINDOW_HEIGHT=$CALCULATED_HEIGHT
    fi

    # Calculate centered position
    POS_X=$(( (MONITOR_WIDTH - WINDOW_WIDTH) / 2 ))
    POS_Y=$(( (MONITOR_HEIGHT - WINDOW_HEIGHT) / 2 ))

    echo "Window dimensions: ${WINDOW_WIDTH}x${WINDOW_HEIGHT} at position (${POS_X}, ${POS_Y})"

    # Make window floating first
    hyprspace layout floating

    # Use Hammerspoon's smooth animation (like Raycast Animated Window Manager)
    if command -v hs &> /dev/null; then
        hs -c "pseudoFullscreenAnimated()"
    else
        echo "⚠️  Hammerspoon not found, falling back to instant positioning"
        osascript -l JavaScript <<EOF 2>/dev/null
var se = Application('System Events');
var frontApp = se.applicationProcesses.whose({ frontmost: true })[0];
var frontWindow = frontApp.windows[0];
frontWindow.size = [$WINDOW_WIDTH, $WINDOW_HEIGHT];
frontWindow.position = [$POS_X, $POS_Y];
EOF
    fi

    # Store state
    echo "$FOCUSED_WINDOW" >> "$STATE_FILE"
    echo "Entered pseudo-fullscreen mode"
fi
