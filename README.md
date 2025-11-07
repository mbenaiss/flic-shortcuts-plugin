# Flic Shortcuts Plugin

A powerful and flexible keyboard shortcut system for Flic buttons on macOS. Create and manage custom shortcuts with ease - no coding required!

## Features

- 🎯 **Easy Shortcut Creation** - Generate shortcuts with a single command
- 🔧 **Multiple Methods** - Use native AppleScript or cliclick
- 📁 **Organized Structure** - Clean folder organization by category
- ⚙️ **Centralized Config** - Manage all shortcuts from one place
- 🎨 **Templates Included** - Pre-built templates for common use cases
- 🚀 **No Dependencies Required** - AppleScript versions work out of the box

## Quick Start

### Installation

1. Copy the entire `Keyboard Shortcuts.FlicPlugin` folder to:
   ```
   ~/Library/Application Scripts/com.shortcutlabs.FlicMac
   ```

2. You can open this folder directly from Flic app:
   - Open Flic app
   - Go to menu bar: **Plugins → Show Folder...**

3. Reload plugins in Flic app:
   - Go to menu bar: **Plugins → Reload Plugins**
   - Or restart the Flic app

### First Time Setup

1. Open the Flic app
2. Select your Flic button
3. Add a new action
4. Choose "Keyboard Shortcuts" from the action list
5. Select an action from the list
6. Save and test your button!

## Available Shortcuts

### Pre-configured Shortcuts

1. **Quick Transcription** (Ctrl+Shift+W)
   - Trigger transcription with keyboard shortcut
   - Configure the same shortcut in your transcription app

2. **Mute/Unmute Microphone**
   - Toggle microphone mute state
   - Uses native macOS audio controls

3. **Switch to Wireless Microphone**
   - Change audio input device
   - Customize for your specific device

## Creating New Shortcuts

### Method 1: Using the Generator (Recommended)

```bash
cd tools
./shortcut-generator.sh create \
  --name "My Custom Shortcut" \
  --type keyboard \
  --keys "cmd+shift+x" \
  --description "Does something awesome"
```

The generator will:
- Create the script file
- Set correct permissions
- Provide the config JSON to add
- Show you next steps

### Method 2: Using Templates

1. Choose a template from `tools/templates/`
2. Copy to appropriate shortcuts directory
3. Replace all `{{VARIABLES}}`
4. Make executable: `chmod +x your-script.sh`
5. Add to configs (see below)

### Method 3: Manual Creation

1. Create your script in the appropriate folder:
   - `shortcuts/keyboard/` - Keyboard shortcuts
   - `shortcuts/system/` - System commands
   - `shortcuts/apps/` - App-specific actions

2. Make it executable:
   ```bash
   chmod +x shortcuts/keyboard/your-script.sh
   ```

3. Add entry to `shortcuts/shortcut-config.json`

4. Add action to main `config.json`

5. Reload Flic plugins

## Configuration Files

### Main Config (`config.json`)
Defines what appears in the Flic app action list.

### Shortcuts Config (`shortcuts/shortcut-config.json`)
Centralized configuration for all shortcuts with metadata and settings.

### Key Mapper (`tools/key-mapper.json`)
Reference for keyboard key codes and modifiers.

## Shortcut Types

### Keyboard Shortcuts

Trigger keyboard combinations using either:

**AppleScript (Native - Recommended)**
```bash
osascript -e 'tell application "System Events" to keystroke "w" using {control down, shift down}'
```

**cliclick (Requires installation)**
```bash
/opt/homebrew/bin/cliclick -w 50 kd:ctrl,shift t:w ku:ctrl,shift
```

### System Commands

Execute any macOS command:
```bash
# Example: Open an app
open -a "Safari"

# Example: System volume
osascript -e "set volume output volume 50"
```

### Application Launchers

Smart app launching (opens or activates):
```bash
if pgrep -x "Slack" > /dev/null; then
    osascript -e 'tell application "Slack" to activate'
else
    open -a "Slack"
fi
```

## Project Structure

```
Keyboard Shortcuts.FlicPlugin/
├── config.json                    # Main Flic plugin config
├── shortcuts/                     # All shortcut scripts
│   ├── shortcut-config.json      # Centralized shortcuts config
│   ├── keyboard/                 # Keyboard shortcut scripts
│   │   └── transcription.sh
│   ├── system/                   # System command scripts
│   │   ├── mute-mic.sh
│   │   └── switch-to-wireless-mic.sh
│   └── apps/                     # App-specific scripts
├── tools/                        # Utilities
│   ├── shortcut-generator.sh    # CLI tool to create shortcuts
│   ├── key-mapper.json          # Keyboard reference
│   └── templates/               # Script templates
│       ├── keyboard-shortcut-applescript.template.sh
│       ├── keyboard-shortcut-cliclick.template.sh
│       ├── system-command.template.sh
│       └── app-launcher.template.sh
└── README.md                     # This file
```

## Advanced Usage

### Listing All Shortcuts

```bash
cd tools
./shortcut-generator.sh list
```

### Key Combinations

Common modifier keys:
- `cmd` or `command` - ⌘ Command
- `ctrl` or `control` - ⌃ Control
- `opt` or `option` or `alt` - ⌥ Option
- `shift` - ⇧ Shift

Examples:
- `cmd+shift+w`
- `ctrl+opt+delete`
- `shift+space`

### Dependencies

**AppleScript versions (Recommended):**
- ✅ No dependencies
- ✅ Built into macOS
- ✅ Works everywhere

**cliclick versions:**
- Requires: `brew install cliclick`
- More reliable for some apps
- Better for complex sequences

## Troubleshooting

### Shortcuts not working?

1. **Check Accessibility Permissions**
   - System Settings → Privacy & Security → Accessibility
   - Ensure Flic has permission

2. **Delete and recreate the workflow**
   - Flic may cache old configurations
   - Remove the action and add it again

3. **Verify script permissions**
   ```bash
   chmod +x shortcuts/keyboard/*.sh
   chmod +x shortcuts/system/*.sh
   ```

4. **Test script manually**
   ```bash
   ./shortcuts/keyboard/transcription.sh
   ```

### Generator not working?

Make sure it's executable:
```bash
chmod +x tools/shortcut-generator.sh
```

### AppleScript vs cliclick?

| Feature | AppleScript | cliclick |
|---------|------------|----------|
| Dependencies | None | Requires Homebrew |
| Reliability | Good | Better |
| Setup | Zero | Install required |
| Compatibility | Universal | Universal |

**Recommendation:** Start with AppleScript, switch to cliclick if needed.

## Examples

### Create a Spotify Control Shortcut

```bash
./tools/shortcut-generator.sh create \
  --name "Play/Pause Spotify" \
  --type keyboard \
  --keys "cmd+shift+space" \
  --description "Control Spotify playback"
```

### Create an App Launcher

```bash
./tools/shortcut-generator.sh create \
  --name "Open Terminal" \
  --type system_command \
  --description "Opens Terminal app"
```

Then edit the generated script to add:
```bash
open -a "Terminal"
```

## Contributing

Found a bug or have a suggestion? Open an issue on GitHub!

Want to share your shortcuts? Submit a PR with your custom shortcuts in a new directory.

## License

MIT License - Feel free to modify and share!

## Support

- **Issues:** https://github.com/mbenaiss/flic-shortcuts-plugin/issues
- **Flic Documentation:** https://flic.io/
- **AppleScript Guide:** https://developer.apple.com/library/archive/documentation/AppleScript/

---

Made with ❤️ for the Flic community
