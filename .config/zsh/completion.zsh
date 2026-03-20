# Zsh completion configuration

# Create cache directory if it doesn't exist
[[ -d "$XDG_CACHE_HOME/zsh" ]] || mkdir -p "$XDG_CACHE_HOME/zsh"

# Configure completion system
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/zcompdump"
zstyle ':completion:*' use-cache on
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Load completions
# Only run compinit once per day for faster startup (saves ~100-200ms)
autoload -Uz compinit
if [[ -n ${ZSH_COMPDUMP}(#qN.mh+24) ]]; then
  compinit -d "$ZSH_COMPDUMP"
else
  compinit -C -d "$ZSH_COMPDUMP"
fi