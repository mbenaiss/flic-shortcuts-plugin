#!/bin/bash
# {{SHORTCUT_NAME}}
# {{DESCRIPTION}}
# Method: AppleScript (native, no dependencies)

# Trigger keyboard shortcut: {{KEYS}}
osascript -e 'tell application "System Events" to keystroke "{{KEY}}" using {{{MODIFIERS}}}'
