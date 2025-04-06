# tmux working dynamic cursor function
# ZLE hooks for prompt's Vim mode status
function zle-line-init zle-keymap-select {
	# Change the cursor style depending on keymap mode.
	if [[ "$SSH_CONNECTION" == '' ]] {
		case $KEYMAP {
			vicmd)
				printf '\e[2 q' # Box.
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
