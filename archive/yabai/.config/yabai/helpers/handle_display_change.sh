#!/usr/bin/env bash

# Handle display topology changes (connect/disconnect external monitors)
# This script ensures labeled spaces remain consistent when displays change

LOGFILE="$HOME/.config/yabai/display_change.log"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $*" | tee -a "$LOGFILE"
}

log "=== Display change detected ==="

# Wait for display topology to stabilize
sleep 2

# Get current display count
DISPLAY_COUNT=$(yabai -m query --displays | jq '. | length')
log "Display count: $DISPLAY_COUNT"

# Re-run ensure_spaces to fix any space labeling issues
log "Running ensure_spaces.sh to restore workspace labels..."
"$HOME/.config/yabai/helpers/ensure_spaces.sh" >> "$LOGFILE" 2>&1

# Redistribute spaces across displays if multiple monitors exist
if [ "$DISPLAY_COUNT" -gt 1 ]; then
    log "Multiple displays detected - redistributing spaces"

    # Strategy: Move spaces y,u,i,o,p to display 2
    # This keeps q,w,e,r,t on display 1 and y,u,i,o,p on display 2
    for label in y u i o p; do
        SPACE_DISPLAY=$(yabai -m query --spaces | jq -r ".[] | select(.label == \"$label\") | .display")
        if [ "$SPACE_DISPLAY" != "2" ]; then
            log "Moving space '$label' to display 2"
            yabai -m space "$label" --display 2 2>&1 | tee -a "$LOGFILE"
        fi
    done
else
    log "Single display mode - all spaces on display 1"
fi

# Refresh sketchybar to reflect changes
sketchybar --trigger yabai_display_change 2>/dev/null

log "=== Display change handling complete ==="
log ""
