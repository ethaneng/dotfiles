#!/usr/bin/env sh

#
# Yabai Floating Window Rules
# Synced with AeroSpace configuration
#
# Rule Options:
#   manage=off          - Window will float (not be tiled)
#   sticky=on           - Window appears on all spaces
#   layer=above         - Window stays on top of other windows
#   layer=below         - Window stays below other windows
#   border=off          - Disable border for this window
#   opacity=<float>     - Set window opacity (0.0 - 1.0)
#
# Matching Options:
#   app="^Name$"        - Match by application name (regex)
#   title="pattern"     - Match by window title (regex)
#   role="AXRole"       - Match by accessibility role
#   subrole="AXSubrole" - Match by accessibility subrole
#
# Examples:
#   yabai -m rule --add app="^App$" manage=off
#   yabai -m rule --add app="^App$" manage=off sticky=on layer=above
#   yabai -m rule --add title="pattern" manage=off
#
# To find app names, run while app is open:
#   yabai -m query --windows | jq '.[] | select(.app != "") | .app' | sort -u
#

# System Applications
# Maps to: if.app-id = 'com.apple.systempreferences'
yabai -m rule --add app="^System Preferences$" manage=off
yabai -m rule --add app="^System Settings$" manage=off

# Screenshot/Utility Apps
# Maps to: if.app-name-regex-substring = 'shottr'
yabai -m rule --add app="^Shottr$" manage=off

# Window Title Rules
# Maps to: if.window-title-regex-substring = 'Picture-in-Picture'
yabai -m rule --add title="^Picture-in-Picture$" manage=off

# Maps to: if.window-title-regex-substring = 'reminder'
yabai -m rule --add title="[Rr]eminder" manage=off sticky=on layer=above

# Maps to: if.window-title-regex-substring = 'new meeting .* microsoft teams'
yabai -m rule --add title="[Nn]ew meeting.*[Mm]icrosoft [Tt]eams" manage=off

yabai -m rule --add title="[Ll]eader [Kk]ey" manage=off

yabai -m rule --add title="Claude" manage=off

yabai -m rule --add app="^Messages$" manage=off

yabai -m signal --add event=window_created action='
  yabai -m query --windows --window $YABAI_WINDOW_ID | jq -er ".\"can-resize\" or .\"is-floating\"" || \
  yabai -m window $YABAI_WINDOW_ID --toggle float && \
  yabai -m window $YABAI_WINDOW_ID --layer above && \
  yabai -m window $YABAI_WINDOW_ID --grid 3:3:1:1:1:1
'

echo "yabai window rules loaded.."
