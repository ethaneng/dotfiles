# Environment variables and PATH configuration

# PATH configuration
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH

# Language settings
export LANG=en_US.UTF-8

# Editor configuration
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='zed'
fi

# Neovim configuration
export NVIM_APPNAME="lazynvim"

# History timestamp format
HIST_STAMPS="dd/mm/yyyy"

# Zoxide configuration
export ZOXIDE_CMD_OVERRIDE="z"

# Starship promp config
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/zsh/starship.toml
