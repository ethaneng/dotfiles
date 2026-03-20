#!/bin/bash
# Toggle monocle via sending hyper-z keycode to the system (this needs to match the binding in monocle)
osascript -e 'tell application "System Events" to keystroke "z" using {control down, shift down, option down, command down}'
