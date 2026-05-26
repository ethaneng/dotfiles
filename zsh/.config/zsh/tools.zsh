# Tool-specific configurations

# NVM configuration - Lazy loaded for faster shell startup
export NVM_DIR=~/.nvm

# Lazy load nvm - only initialize when needed (saves ~200-500ms on startup)
nvm() {
  unset -f nvm node npm npx
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
  nvm "$@"
}

node() {
  unset -f nvm node npm npx
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
  node "$@"
}

npm() {
  unset -f nvm node npm npx
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
  npm "$@"
}

npx() {
  unset -f nvm node npm npx
  [ -s "$(brew --prefix nvm)/nvm.sh" ] && \. "$(brew --prefix nvm)/nvm.sh"
  npx "$@"
}

# PNPM configuration
export PNPM_HOME="/Users/ethan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# init zoxide
eval "$(zoxide init zsh)"

# ========================================
# Interactive CLI Tool Launcher with gum
# ========================================

# Configuration file for tools
export CLI_TOOLS_CONFIG="$ZDOTDIR/cli-tools.json"

# Display style options: "bullets", "brackets", "compact"
export CLI_TOOLS_DISPLAY_STYLE="${CLI_TOOLS_DISPLAY_STYLE:-bullets}"

# Initialize tools config if it doesn't exist
_init_cli_tools_config() {
  if [[ ! -f "$CLI_TOOLS_CONFIG" ]]; then
    cat > "$CLI_TOOLS_CONFIG" << 'EOF'
{
  "tools": [
    {
      "name": "lazygit",
      "command": "lazygit",
      "description": "Simple terminal UI for git commands",
      "tags": ["git", "tui"]
    },
    {
      "name": "htop",
      "command": "htop",
      "description": "Interactive process viewer",
      "tags": ["monitor", "tui", "system"]
    },
    {
      "name": "btm",
      "command": "btm",
      "description": "Cross-platform graphical process/system monitor",
      "tags": ["monitor", "tui", "system", "performance"]
    },
    {
      "name": "fd",
      "command": "fd --type f --hidden --exclude .git | head -20",
      "description": "Find files (first 20 results)",
      "tags": ["search", "files", "cli"]
    },
    {
      "name": "rg-search",
      "command": "rg --files --hidden --glob '!.git' | head -20",
      "description": "Search files with ripgrep (first 20 results)",
      "tags": ["search", "files", "ripgrep", "cli"]
    }
  ]
}
EOF
    echo "Initialized CLI tools config at $CLI_TOOLS_CONFIG"
  fi
}

# Main function to launch interactive tool picker
launcher() {
  # Check if gum is available
  if ! command -v gum &> /dev/null; then
    echo "Error: gum is not installed. Install it with: brew install gum"
    return 1
  fi

  # Check if jq is available
  if ! command -v jq &> /dev/null; then
    echo "Error: jq is not installed. Install it with: brew install jq"
    return 1
  fi

  # Initialize config
  _init_cli_tools_config

  # Create formatted tool list with proper alignment and spacing
  local formatted_tools
  case "$CLI_TOOLS_DISPLAY_STYLE" in
    "brackets")
      formatted_tools=$(jq -r '.tools[] | 
        "█ " + (.name | . + (" " * (20 - length))) + " │ " + .description + 
        (if .tags and (.tags | length > 0) then 
          " │ [" + (.tags | join("] [")) + "]"
        else 
          ""
        end)' "$CLI_TOOLS_CONFIG")
      ;;
    "compact")
      formatted_tools=$(jq -r '.tools[] | 
        "█ " + (.name | . + (" " * (20 - length))) + " │ " + .description + 
        (if .tags and (.tags | length > 0) then 
          " │ ◦ " + (.tags | join(" ◦ "))
        else 
          ""
        end)' "$CLI_TOOLS_CONFIG")
      ;;
    *)
      # Default "bullets" style  
      formatted_tools=$(jq -r '.tools[] | 
        "█ " + (.name | . + (" " * (20 - length))) + " │ " + .description + 
        (if .tags and (.tags | length > 0) then 
          " │ • " + (.tags | join(" • "))
        else 
          ""
        end)' "$CLI_TOOLS_CONFIG")
      ;;
  esac
  
  if [[ -z "$formatted_tools" ]]; then
    echo "No tools configured. Use 'launcher-add' to add some tools."
    return 1
  fi

  # Use gum to select a tool with improved styling
  local selected=$(echo "$formatted_tools" | gum choose \
    --header="🚀 Select a CLI Tool" \
    --header.foreground="#FF79C6" \
    --selected.foreground="#50FA7B" \
    --cursor="▶ " \
    --cursor.foreground="#8BE9FD" \
    --height=15)
  
  if [[ -n "$selected" ]]; then
    # Extract tool name from the formatted selection (remove padding spaces)
    local tool_name=$(echo "$selected" | sed 's/^█ \([^│]*\) │.*$/\1/' | sed 's/[[:space:]]*$//')
    local command=$(jq -r --arg name "$tool_name" '.tools[] | select(.name == $name) | .command' "$CLI_TOOLS_CONFIG")
    
    if [[ -n "$command" ]]; then
      echo ""
      echo "🔧 Launching: $(gum style --foreground '#50FA7B' --bold "$tool_name")"
      echo "📋 Command: $(gum style --foreground '#F8F8F2' --italic "$command")"
      echo ""
      gum spin --spinner dot --title "Starting $tool_name..." -- sleep 0.5
      eval "$command"
    else
      echo "❌ Error: Could not find command for tool '$tool_name'"
    fi
  fi
}

# Add a new tool to the configuration
launcher-add() {
  # Check dependencies
  if ! command -v gum &> /dev/null || ! command -v jq &> /dev/null; then
    echo "Error: gum and jq are required. Install with: brew install gum jq"
    return 1
  fi

  _init_cli_tools_config

  # Prompt for tool details
  local name=$(gum input --placeholder "Tool name (e.g., 'docker-ps')")
  if [[ -z "$name" ]]; then
    echo "Tool name is required"
    return 1
  fi

  local command=$(gum input --placeholder "Command to execute (e.g., 'docker ps -a')")
  if [[ -z "$command" ]]; then
    echo "Command is required"
    return 1
  fi

  local description=$(gum input --placeholder "Description (e.g., 'List all Docker containers')")
  if [[ -z "$description" ]]; then
    description="No description"
  fi

  local tags_input=$(gum input --placeholder "Tags (comma-separated, e.g., 'docker,containers,dev')")
  local tags_array="[]"
  if [[ -n "$tags_input" ]]; then
    # Convert comma-separated tags to JSON array
    tags_array=$(echo "$tags_input" | sed 's/[[:space:]]*,[[:space:]]*/\n/g' | jq -R . | jq -s .)
  fi

  # Check if tool already exists
  if jq -e --arg name "$name" '.tools[] | select(.name == $name)' "$CLI_TOOLS_CONFIG" > /dev/null 2>&1; then
    echo "Tool '$name' already exists. Use 'launcher-edit' to modify it."
    return 1
  fi

  # Add the new tool
  local temp_file=$(mktemp)
  jq --arg name "$name" --arg cmd "$command" --arg desc "$description" --argjson tags "$tags_array" \
    '.tools += [{"name": $name, "command": $cmd, "description": $desc, "tags": $tags}]' \
    "$CLI_TOOLS_CONFIG" > "$temp_file" && mv "$temp_file" "$CLI_TOOLS_CONFIG"

  echo "Added tool '$name' successfully!"
}

# Remove a tool from the configuration
launcher-remove() {
  if ! command -v gum &> /dev/null || ! command -v jq &> /dev/null; then
    echo "Error: gum and jq are required"
    return 1
  fi

  _init_cli_tools_config

  # Show current tools for selection
  local tools_list=$(jq -r '.tools[] | .name' "$CLI_TOOLS_CONFIG")
  
  if [[ -z "$tools_list" ]]; then
    echo "No tools configured."
    return 1
  fi

  local selected=$(echo "$tools_list" | gum choose \
    --header="🗑️  Select a tool to remove" \
    --header.foreground="#FF5555" \
    --cursor="▶ " \
    --height=10)
  
  if [[ -n "$selected" ]]; then
    # Confirm removal
    if gum confirm --default=false "🗑️  Remove tool '$selected'?"; then
      local temp_file=$(mktemp)
      jq --arg name "$selected" '.tools = (.tools | map(select(.name != $name)))' \
        "$CLI_TOOLS_CONFIG" > "$temp_file" && mv "$temp_file" "$CLI_TOOLS_CONFIG"
      echo "Removed tool '$selected'"
    fi
  fi
}

# List all configured tools
launcher-list() {
  _init_cli_tools_config

  if ! command -v jq &> /dev/null; then
    echo "Error: jq is required. Install with: brew install jq"
    return 1
  fi

  echo ""
  echo "$(gum style --foreground '#BD93F9' --bold '📋 Configured CLI Tools')"
  echo "$(gum style --foreground '#6272A4' '========================')"
  echo ""
  
  # Format tools with better visual hierarchy including tags
  jq -r '.tools[] | 
    "$(gum style --foreground '\''#50FA7B'\'' --bold '\''█ \(.name)'\'') " +
    (if .tags and (.tags | length > 0) then 
      "$(gum style --foreground '\''#BD93F9'\'' '\''[\(.tags | join(", "))]'\'')"
    else 
      ""
    end) +
    "\n$(gum style --foreground '\''#F8F8F2'\'' --italic '\''  \(.description)'\'') \n$(gum style --foreground '\''#6272A4'\'' '\''  Command: \(.command)'\'') \n"' "$CLI_TOOLS_CONFIG" | while IFS= read -r line; do
    eval "echo \"$line\""
  done
}

# Edit an existing tool
launcher-edit() {
  if ! command -v gum &> /dev/null || ! command -v jq &> /dev/null; then
    echo "Error: gum and jq are required"
    return 1
  fi

  _init_cli_tools_config

  # Show current tools for selection
  local tools_list=$(jq -r '.tools[] | .name' "$CLI_TOOLS_CONFIG")
  
  if [[ -z "$tools_list" ]]; then
    echo "No tools configured."
    return 1
  fi

  local selected=$(echo "$tools_list" | gum choose \
    --header="✏️  Select a tool to edit" \
    --header.foreground="#F1FA8C" \
    --cursor="▶ " \
    --height=10)
  
  if [[ -n "$selected" ]]; then
    # Get current values
    local current_command=$(jq -r --arg name "$selected" '.tools[] | select(.name == $name) | .command' "$CLI_TOOLS_CONFIG")
    local current_description=$(jq -r --arg name "$selected" '.tools[] | select(.name == $name) | .description' "$CLI_TOOLS_CONFIG")
    local current_tags=$(jq -r --arg name "$selected" '.tools[] | select(.name == $name) | .tags // [] | join(", ")' "$CLI_TOOLS_CONFIG")

    echo "Editing tool: $selected"
    echo "Leave fields empty to keep current values"
    echo ""

    # Prompt for new values
    local new_command=$(gum input --placeholder "Command" --value "$current_command")
    local new_description=$(gum input --placeholder "Description" --value "$current_description")
    local new_tags_input=$(gum input --placeholder "Tags (comma-separated)" --value "$current_tags")

    # Use current values if no new input
    [[ -z "$new_command" ]] && new_command="$current_command"
    [[ -z "$new_description" ]] && new_description="$current_description"
    
    # Convert tags input to JSON array
    local new_tags_array="[]"
    if [[ -n "$new_tags_input" ]]; then
      new_tags_array=$(echo "$new_tags_input" | sed 's/[[:space:]]*,[[:space:]]*/\n/g' | jq -R . | jq -s .)
    fi

    # Update the tool
    local temp_file=$(mktemp)
    jq --arg name "$selected" --arg cmd "$new_command" --arg desc "$new_description" --argjson tags "$new_tags_array" \
      '(.tools[] | select(.name == $name) | .command) = $cmd | 
       (.tools[] | select(.name == $name) | .description) = $desc |
       (.tools[] | select(.name == $name) | .tags) = $tags' \
      "$CLI_TOOLS_CONFIG" > "$temp_file" && mv "$temp_file" "$CLI_TOOLS_CONFIG"

    echo "Updated tool '$selected'"
  fi
}

# Change display style for the launcher
launcher-style() {
  if ! command -v gum &> /dev/null; then
    echo "Error: gum is required"
    return 1
  fi

  echo "Current style: $CLI_TOOLS_DISPLAY_STYLE"
  echo ""

  local selected=$(echo -e "bullets\nbrackets\ncompact" | gum choose \
    --header="🎨 Select display style" \
    --header.foreground="#BD93F9" \
    --cursor="▶ " \
    --height=5)
  
  if [[ -n "$selected" ]]; then
    export CLI_TOOLS_DISPLAY_STYLE="$selected"
    echo "Display style changed to: $CLI_TOOLS_DISPLAY_STYLE"
    echo ""
    echo "Preview:"
    echo "========"
    source /Users/ethan/dotfiles/.config/zsh/tools.zsh
    jq -r '.tools[0:2][] | 
      "█ \(.name) │ \(.description)" + 
      (if .tags and (.tags | length > 0) then 
        (if env.CLI_TOOLS_DISPLAY_STYLE == "brackets" then 
          " [" + (.tags | join("][")) + "]"
        elif env.CLI_TOOLS_DISPLAY_STYLE == "compact" then 
          " ◦ " + (.tags | join(" ◦ "))
        else 
          " • " + (.tags | join(" • "))
        end)
      else 
        ""
      end)' "$CLI_TOOLS_CONFIG"
  fi
}

# Alias for the main launcher function
alias tl='launcher'

