#!/usr/bin/env bash

# ################################################################ #
# Update JankyBorders Script
# ################################################################ #
#
# Equivalent to AeroSpace's borders update script.
# Called when fullscreen state changes to hide/show borders.
#
# Usage:
#   Called automatically from layout.conf when toggling fullscreen
#

# Get current window information
WINDOW_ID=$(yabai -m query --windows --window | jq -r '.id')
FULLSCREEN=$(yabai -m query --windows --window | jq -r '."has-fullscreen-zoom"')

# Update borders based on fullscreen state
if [ "$FULLSCREEN" = "true" ]; then
  # Hide borders in fullscreen
  borders width=0
else
  # Show borders in normal mode (adjust width to match your preference)
  borders width=5
fi
