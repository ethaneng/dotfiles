export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH
export PATH=/opt/homebrew/bin:$PATH
export PNPM_HOME="/Users/ethan/.local/share/pnpm"
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

function yazi_zed() {
	local tmp="$(mktemp -t "yazi-chooser.XXXXX")"
	yazi "$@" --chooser-file="$tmp"

	local opened_file="$(cat -- "$tmp" | head -n 1)"
	zed -- "$opened_file"

	rm -f -- "$tmp"
	exit
}
