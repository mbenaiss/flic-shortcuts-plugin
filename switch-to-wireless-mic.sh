#!/bin/bash
# Switch input audio to Wireless microphone

/opt/homebrew/bin/SwitchAudioSource -t input -s "Wireless microphone"

# Check if the switch was successful
if [ $? -eq 0 ]; then
    echo "Switched to Wireless microphone"
else
    echo "Failed to switch to Wireless microphone"
    exit 1
fi
