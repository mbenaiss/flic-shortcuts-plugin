#!/bin/bash
# Toggle microphone mute using osascript

# Get current input volume
current_volume=$(osascript -e "input volume of (get volume settings)")

# Toggle mute: if volume is 0, set to 100, otherwise set to 0
if [ "$current_volume" -eq 0 ]; then
    osascript -e "set volume input volume 100"
    echo "Microphone unmuted"
else
    osascript -e "set volume input volume 0"
    echo "Microphone muted"
fi
