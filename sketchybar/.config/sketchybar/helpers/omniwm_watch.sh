#!/bin/sh

set -u

CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/sketchybar"
PIDFILE="$CACHE_DIR/omniwm_watch.pid"
ROUTER="$HOME/.config/sketchybar/helpers/omniwm_event_router.sh"

mkdir -p "$CACHE_DIR"

if [ -f "$PIDFILE" ]; then
  EXISTING_PID=$(cat "$PIDFILE" 2>/dev/null || true)
  if [ -n "$EXISTING_PID" ] && kill -0 "$EXISTING_PID" 2>/dev/null; then
    exit 0
  fi
fi

printf '%s\n' "$$" > "$PIDFILE"

cleanup() {
  rm -f "$PIDFILE"
}

trap cleanup EXIT INT TERM

while :; do
  if omniwmctl ping >/dev/null 2>&1; then
    sketchybar --trigger omniwm_workspace_change
    omniwmctl watch workspace-bar,display-changed --no-send-initial --exec "$ROUTER"
  fi

  sleep 2
done
