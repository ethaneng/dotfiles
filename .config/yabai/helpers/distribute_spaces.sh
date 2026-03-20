#!/usr/bin/env bash

# Manually distribute spaces across displays
# Run this if spaces get reshuffled after monitor changes
# Usage: ./distribute_spaces.sh

echo "=== Distributing spaces across displays ==="

# Get display count
DISPLAY_COUNT=$(yabai -m query --displays | jq '. | length')
echo "Detected $DISPLAY_COUNT display(s)"

if [ "$DISPLAY_COUNT" -eq 1 ]; then
    echo "Single display mode - moving all spaces to display 1"
    for label in q w e r t y u i o p; do
        yabai -m space "$label" --display 1 2>/dev/null
    done
elif [ "$DISPLAY_COUNT" -ge 2 ]; then
    echo "Multi-display mode - distributing spaces"
    echo "  Display 1: q, w, e, r, t"
    echo "  Display 2: y, u, i, o, p"

    # Move first 5 to display 1
    for label in q w e r t; do
        echo "Moving space '$label' to display 1..."
        yabai -m space "$label" --display 1 2>/dev/null
    done

    # Move second 5 to display 2
    for label in y u i o p; do
        echo "Moving space '$label' to display 2..."
        yabai -m space "$label" --display 2 2>/dev/null
    done
fi

echo ""
echo "Current space distribution:"
yabai -m query --spaces | jq -r '.[] | "Space \(.index) (\(.label)) - Display \(.display)"'

echo ""
echo "=== Distribution complete ==="
