export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"

# PATH configuration (needed for non-interactive shells like LeaderKey.app)
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.local/share/pnpm:$PATH"

export ZDOTDIR=$XDG_CONFIG_HOME/zsh
export ZSH_CACHE_DIR="$XDG_CACHE_HOME/zsh"
