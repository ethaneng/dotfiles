#!/usr/bin/env bash

# ################################################################ #
# Display Wrap-Around Script
# ################################################################ #
#
# Moves the current space to the next/previous display with
# wrap-around support (like AeroSpace's --wrap-around next).
#
# Usage:
#   wrap_display.sh next   - Move space to next display
#   wrap_display.sh prev   - Move space to previous display
#

DIRECTION=$1

# Get current display index
CURRENT_DISPLAY=$(yabai -m query --displays --display | jq -r '.index')

# Get total number of displays
DISPLAY_COUNT=$(yabai -m query --displays | jq 'length')

# Calculate next/previous display with wrap-around
if [ "$DIRECTION" = "next" ]; then
  NEXT_DISPLAY=$(( (CURRENT_DISPLAY % DISPLAY_COUNT) + 1 ))
else
  NEXT_DISPLAY=$(( (CURRENT_DISPLAY - 2 + DISPLAY_COUNT) % DISPLAY_COUNT + 1 ))
fi

# Move current space to calculated display
yabai -m space --display "$NEXT_DISPLAY"
