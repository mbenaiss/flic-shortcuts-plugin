# Shortcut Templates

This directory contains templates for creating new shortcuts quickly.

## Available Templates

### 1. keyboard-shortcut-applescript.template.sh
**Native AppleScript keyboard shortcut (no dependencies)**

Variables to replace:
- `{{SHORTCUT_NAME}}` - Name of your shortcut
- `{{DESCRIPTION}}` - Description
- `{{KEYS}}` - Full key combination (e.g., "Cmd+Shift+W")
- `{{KEY}}` - The main key (e.g., "w")
- `{{MODIFIERS}}` - AppleScript modifiers (e.g., "command down, shift down")

Example:
```bash
# Replace variables
sed 's/{{SHORTCUT_NAME}}/My Custom Shortcut/g' keyboard-shortcut-applescript.template.sh > ../shortcuts/keyboard/my-shortcut.sh
```

### 2. keyboard-shortcut-cliclick.template.sh
**cliclick-based keyboard shortcut (requires cliclick)**

Variables to replace:
- `{{SHORTCUT_NAME}}` - Name of your shortcut
- `{{DESCRIPTION}}` - Description
- `{{KEYS}}` - Full key combination
- `{{KEY}}` - The main key
- `{{MODIFIERS_DOWN}}` - Keys to press (e.g., "cmd,shift")
- `{{MODIFIERS_UP}}` - Keys to release (e.g., "shift,cmd")

### 3. system-command.template.sh
**Generic system command template**

Variables to replace:
- `{{SHORTCUT_NAME}}` - Name of your shortcut
- `{{DESCRIPTION}}` - Description

### 4. app-launcher.template.sh
**Application launcher/switcher**

Variables to replace:
- `{{SHORTCUT_NAME}}` - Name of your shortcut
- `{{DESCRIPTION}}` - Description
- `{{APP_NAME}}` - Name of the application

## Usage with shortcut-generator.sh

The shortcut generator automatically uses these templates when creating new shortcuts:

```bash
./shortcut-generator.sh create \
  --name "My Shortcut" \
  --type keyboard \
  --keys "cmd+shift+x" \
  --description "My custom action"
```

## Manual Usage

1. Choose a template
2. Copy it to the appropriate shortcuts directory
3. Replace all `{{VARIABLES}}`
4. Make it executable: `chmod +x your-script.sh`
5. Add entry to `shortcuts/shortcut-config.json`
6. Update main `config.json`
7. Reload Flic plugins
