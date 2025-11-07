#!/bin/bash
# Trigger keyboard shortcut Ctrl+Shift+W using cliclick
# Commonly used for transcription apps
# Then press Enter to start transcription immediately
/opt/homebrew/bin/cliclick -w 50 kd:ctrl,shift t:w ku:ctrl,shift
sleep 1
osascript -e 'tell application "System Events" to keystroke return'
