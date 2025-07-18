#!/bin/bash

# Sleep here to allow aerospace to fully update fullscreen state
sleep 0.05

# Run the aerospace command to get fullscreen status of all windows
fullscreen_status=$(aerospace list-windows --all --format '%{window-is-fullscreen}')

# Check if any window is fullscreen
if echo "$fullscreen_status" | grep -q "true"; then
  # Set border color to blue
  borders active_color=0xff7fdbca
else
  # Set border color to orange
  borders active_color=0xffffa500
fi
