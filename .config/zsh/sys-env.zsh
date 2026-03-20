# Environment variables and PATH configuration

# PATH configuration
export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.claude/local:$PATH"

# JAVA (for react native: https://reactnative.dev/docs/set-up-your-environment?platform=android)
export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-17.jdk/Contents/Home
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Language settings
export LANG=en_US.UTF-8

# Editor configuration
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Neovim configuration
export NVIM_APPNAME="lazynvim"

# History timestamp format
HIST_STAMPS="dd/mm/yyyy"

# Zoxide configuration
export ZOXIDE_CMD_OVERRIDE="z"

# Starship promp config
export STARSHIP_CONFIG=$XDG_CONFIG_HOME/zsh/starship.toml
