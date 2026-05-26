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

# Benchmark zsh startup time (run this to test performance)
function zsh-benchmark() {
  echo "Running 10 shell startup benchmarks..."
  for i in {1..10}; do
    /usr/bin/time zsh -i -c exit 2>&1 | grep real
  done | awk '{sum+=$2; count++} END {print "\nAverage startup time: " sum/count " seconds"}'
}

# Enable auto cd
setopt AUTO_CD

# Display system information on terminal startup (disabled for faster startup)
# Run 'nerdfetch' manually when you want to see system info
# nerdfetch

export PATH=$PATH:/Users/ethan/.spicetify
export PATH="/opt/homebrew/opt/postgresql@17/bin:$PATH"

# bun completions
[ -s "/Users/ethan/.bun/_bun" ] && source "/Users/ethan/.bun/_bun"
