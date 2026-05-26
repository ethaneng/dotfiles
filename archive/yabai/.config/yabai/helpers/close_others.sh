#!/usr/bin/env bash

# ################################################################ #
# Close All Windows Except Current Script
# ################################################################ #
#
# Equivalent to AeroSpace's 'close-all-windows-but-current' command.
# Called from service mode (backspace key).
#
# Usage:
#   Called automatically from modes.conf in service mode
#

# Get all window IDs in current space except the focused one
WINDOWS=$(yabai -m query --windows --space | jq -r '.[] | select(."has-focus" == false) | .id')

# Close each window
for window_id in $WINDOWS; do
  yabai -m window "$window_id" --close
done
