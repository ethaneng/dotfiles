# Global environment settings
# This file is always sourced, even for non-interactive shells

# Set XDG directories
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Configure zsh directory
export ZDOTDIR="$XDG_CONFIG_HOME/zsh"

# Set zcompdump location to keep home directory clean
export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

# NVM_DIR exported here, but nvm is lazy-loaded in tools.zsh for faster startup
export NVM_DIR="$HOME/.nvm"

# PATH configuration for non-interactive shells (required for LeaderKey, etc.)
# This ensures commands like yabai, sketchybar are available in all shell contexts
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
