#!/bin/sh

CHANNEL="${OMNIWM_EVENT_CHANNEL:-}"

case "$CHANNEL" in
  display-changed)
    sketchybar --trigger omniwm_display_change
    ;;
  *)
    sketchybar --trigger omniwm_workspace_change
    ;;
esac
