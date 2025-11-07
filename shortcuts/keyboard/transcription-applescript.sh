#!/bin/bash
# Trigger keyboard shortcut Ctrl+Shift+W using native AppleScript
# Commonly used for transcription apps
# No external dependencies required

osascript -e 'tell application "System Events" to keystroke "w" using {control down, shift down}'
