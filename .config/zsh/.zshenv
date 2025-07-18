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