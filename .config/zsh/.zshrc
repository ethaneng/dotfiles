# Main .zshrc file - modular configuration

# Load configuration modules
source "$ZDOTDIR/sys-env.zsh"     # System Environment variables
source "$ZDOTDIR/environment.zsh" # Environment variables
source "$ZDOTDIR/completion.zsh"  # Completion settings
source "$ZDOTDIR/tools.zsh"       # Tool-specific configuration
source "$ZDOTDIR/theme.zsh"       # Theme changes (init prompt)
source "$ZDOTDIR/binds.zsh"       # Binds
source "$ZDOTDIR/zinit.zsh"      # Load modules with zinit

# Function to clean old completion caches
function clean_compdump() {
  rm -f "$XDG_CACHE_HOME/zsh/zcompdump"*
  compinit -d "$ZSH_COMPDUMP"
  echo "Completion cache cleaned and regenerated."
}

# Enable auto cd
setopt AUTO_CD

# Display system information on terminal startup
nerdfetch

