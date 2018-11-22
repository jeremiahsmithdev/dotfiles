# . `brew --prefix`/etc/profile.d/z.sh

source ~/antigen.zsh
# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Load the theme
# antigen theme https://github.com/denysdovhan/spaceship-zsh-theme spaceship

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle heroku
# antigen bundle pip
# antigen bundle lein
# antigen bundle command-not-found
# antigen bundle autojump
# antigen bundle common-aliases
# antigen bundle compleat
antigen bundle git-extras
antigen bundle git-flow
# antigen bundle npm
antigen bundle web-search
# antigen bundle zsh-users/zsh-history-substring-search ./zsh-history-substring-search.zsh
antigen bundle autosuggestions

# jump to recently used directories by typing the first few letters in the
# directory name
antigen bundle z
# fuzzy search of most recently used directories
antigen bundle b4b4r07/enhancd

# pure theme
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

antigen bundle zsh-users/zsh-syntax-highlighting
# Tell Antigen that you're done.
antigen apply



# Setup zsh-autosuggestions
# source "$HOME/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"

# Load custom aliases
[[ -s "$HOME/.bash_aliases" ]] && source "$HOME/.bash_aliases"


# VIM STUFF
bindkey -v

#kill the lag (switching modes)
export KEYTIMEOUT=1


# tmux working dynamic cursor function
# ZLE hooks for prompt's Vim mode status
function zle-line-init zle-keymap-select {
	# Change the cursor style depending on keymap mode.
	if [[ "$SSH_CONNECTION" == '' ]] {
		case $KEYMAP {
			vicmd)
				printf '\e[0 q' # Box.
				;;

			viopp)
				printf '\e[6 q' # Vertical bar.
				;;

			viins|main)
				printf '\e[6 q' # Vertical bar.
				;;
		}
	}

	# Redraw if necessary.
	zle reset-prompt
	zle -R
}
zle -N zle-line-init
zle -N zle-line-finish
zle -N zle-keymap-select

# mappings
alias v=nvim
bindkey -s ^F 'nvim $(fzf --preview \"cat {}\")\015'

alias c=colorls


