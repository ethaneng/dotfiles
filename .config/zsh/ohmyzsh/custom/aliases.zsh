alias zshsrc="source $ZDOTDIR/.zshrc"

alias ezsh="cd $ZDOTDIR; nvim .zshrc" 
alias econfig="cd $XDG_CONFIG_HOME; nvim"
alias ewezterm="cd $XDG_CONFIG_HOME/wezterm; nvim wezterm.lua"
alias envim="cd $XDG_CONFIG_HOME/nvim; nvim"
alias etmux="cd $XDG_CONFIG_HOME/tmux; nvim tmux.conf"

alias sd="z \$(find * -type d | fzf)"
