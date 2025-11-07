#!/bin/bash
# {{SHORTCUT_NAME}}
# {{DESCRIPTION}}
# Type: Application Launcher

APP_NAME="{{APP_NAME}}"

# Check if app is running
if pgrep -x "$APP_NAME" > /dev/null; then
    # App is running, bring to front
    osascript -e "tell application \"$APP_NAME\" to activate"
else
    # App is not running, launch it
    open -a "$APP_NAME"
fi
