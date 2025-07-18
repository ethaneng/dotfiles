# Zsh completion configuration

# Create cache directory if it doesn't exist
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Configure completion system
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Load completions
autoload -Uz compinit
compinit -d "$ZSH_COMPDUMP"