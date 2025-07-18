# Tool-specific configurations

# NVM configuration
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# PNPM configuration
export PNPM_HOME="/Users/ethan/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# init zoxide
eval "$(zoxide init zsh)"

