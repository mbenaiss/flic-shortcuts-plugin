#!/bin/bash
# Shortcut Generator - Create new shortcuts easily
# Usage: ./shortcut-generator.sh create --name "My Shortcut" --type keyboard --keys "cmd+shift+x"

set -e

SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
PLUGIN_DIR="$(dirname "$SCRIPT_DIR")"
CONFIG_FILE="$PLUGIN_DIR/shortcuts/shortcut-config.json"
MAIN_CONFIG="$PLUGIN_DIR/config.json"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

function show_help() {
    echo -e "${BLUE}Shortcut Generator${NC}"
    echo ""
    echo "Usage:"
    echo "  $0 create [OPTIONS]"
    echo "  $0 list"
    echo "  $0 enable <shortcut-id>"
    echo "  $0 disable <shortcut-id>"
    echo ""
    echo "Create Options:"
    echo "  --name <name>           Name of the shortcut"
    echo "  --type <type>           Type: keyboard, system_command, or app_action"
    echo "  --keys <keys>           Keyboard combination (e.g., 'cmd+shift+x')"
    echo "  --description <desc>    Description of the shortcut"
    echo "  --category <category>   Category: keyboard, system, or apps"
    echo ""
    echo "Examples:"
    echo "  $0 create --name \"My Shortcut\" --type keyboard --keys \"cmd+shift+x\" --description \"My action\""
    echo "  $0 list"
    echo "  $0 enable transcription"
}

function generate_id() {
    local name=$1
    echo "$name" | tr '[:upper:]' '[:lower:]' | tr ' ' '_' | tr -cd '[:alnum:]_'
}

function convert_keys_to_cliclick() {
    local keys=$1
    local result=""
    local key_down=""
    local key_press=""
    local key_up=""

    # Split by '+'
    IFS='+' read -ra PARTS <<< "$keys"

    # Process modifiers
    for part in "${PARTS[@]:0:${#PARTS[@]}-1}"; do
        case "$part" in
            cmd|command) key_down="$key_down,cmd"; key_up="cmd,$key_up" ;;
            ctrl|control) key_down="$key_down,ctrl"; key_up="ctrl,$key_up" ;;
            opt|option|alt) key_down="$key_down,option"; key_up="option,$key_up" ;;
            shift) key_down="$key_down,shift"; key_up="shift,$key_up" ;;
        esac
    done

    # Clean up leading/trailing commas
    key_down="${key_down#,}"
    key_up="${key_up%,}"

    # Get the actual key
    local actual_key="${PARTS[-1]}"

    # Build cliclick command
    if [ -n "$key_down" ]; then
        echo "/opt/homebrew/bin/cliclick -w 50 kd:$key_down t:$actual_key ku:$key_up"
    else
        echo "/opt/homebrew/bin/cliclick -w 50 t:$actual_key"
    fi
}

function create_shortcut() {
    local name=""
    local type="keyboard"
    local keys=""
    local description=""
    local category="keyboard"

    # Parse arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --name) name="$2"; shift 2 ;;
            --type) type="$2"; shift 2 ;;
            --keys) keys="$2"; shift 2 ;;
            --description) description="$2"; shift 2 ;;
            --category) category="$2"; shift 2 ;;
            *) echo -e "${RED}Unknown option: $1${NC}"; show_help; exit 1 ;;
        esac
    done

    # Validate required fields
    if [ -z "$name" ]; then
        echo -e "${RED}Error: --name is required${NC}"
        exit 1
    fi

    if [ "$type" = "keyboard" ] && [ -z "$keys" ]; then
        echo -e "${RED}Error: --keys is required for keyboard shortcuts${NC}"
        exit 1
    fi

    # Generate ID
    local id=$(generate_id "$name")

    echo -e "${BLUE}Creating shortcut: $name${NC}"
    echo "ID: $id"
    echo "Type: $type"
    echo "Category: $category"

    # Create script file
    local script_path="$PLUGIN_DIR/shortcuts/$category/$id.sh"

    if [ -f "$script_path" ]; then
        echo -e "${YELLOW}Warning: Script already exists at $script_path${NC}"
        read -p "Overwrite? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            echo "Cancelled."
            exit 0
        fi
    fi

    # Generate script content
    if [ "$type" = "keyboard" ]; then
        local cliclick_cmd=$(convert_keys_to_cliclick "$keys")
        cat > "$script_path" <<EOF
#!/bin/sh
# $name
# $description
$cliclick_cmd
EOF
    else
        cat > "$script_path" <<EOF
#!/bin/bash
# $name
# $description

# Add your custom command here
echo "Executing $name"
EOF
    fi

    chmod +x "$script_path"
    echo -e "${GREEN}✓ Created script: $script_path${NC}"

    # Update shortcut-config.json
    # Note: This is a simple append. For production, use jq or Python
    echo -e "${BLUE}Note: Please manually add this entry to $CONFIG_FILE:${NC}"
    cat <<EOF
{
  "id": "$id",
  "name": "$name",
  "category": "$category",
  "type": "$type",
  $([ "$type" = "keyboard" ] && echo "\"keys\": [$(echo "$keys" | sed 's/+/", "/g' | sed 's/^/"/;s/$/"/;s/""/"/g')],")
  "description": "$description",
  "scriptPath": "shortcuts/$category/$id.sh",
  "enabled": true
}
EOF

    echo ""
    echo -e "${GREEN}✓ Shortcut created successfully!${NC}"
    echo -e "${YELLOW}Remember to:${NC}"
    echo "  1. Add the entry to shortcuts/shortcut-config.json"
    echo "  2. Update config.json actions array"
    echo "  3. Reload plugins in Flic app"
}

function list_shortcuts() {
    echo -e "${BLUE}Available Shortcuts:${NC}"
    echo ""

    # Check if jq is available
    if command -v jq &> /dev/null; then
        jq -r '.shortcuts[] | "[\(.id)] \(.name) - \(.description) [\(if .enabled then "enabled" else "disabled" end)]"' "$CONFIG_FILE"
    else
        echo "Install jq for better formatting, or view $CONFIG_FILE manually"
        cat "$CONFIG_FILE"
    fi
}

# Main command dispatcher
case "${1:-}" in
    create)
        shift
        create_shortcut "$@"
        ;;
    list)
        list_shortcuts
        ;;
    help|--help|-h)
        show_help
        ;;
    "")
        show_help
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}"
        show_help
        exit 1
        ;;
esac
