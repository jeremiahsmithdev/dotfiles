source ~/dotfiles/zshenv
source ~/dotfiles/omz.zsh
source ~/dotfiles/aliases.zsh
source ~/dotfiles/dynamic_cursor.zsh
source ~/dotfiles/fzf_nvim_preview.zsh
source ~/dotfiles/api_keys.sh

export ZSH="$HOME/.oh-my-zsh"
export AIDER_EDITOR=nvim

# plugins=(git zsh-autosuggestions)

# enable vim mode
bindkey -v


# theme
autoload -U promptinit; promptinit
prompt pure

bindkey '^F' fzf_nvim_preview

 . $(brew --prefix)/etc/profile.d/z.sh

 # zsh-autosuggestions
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
bindkey '^E' autosuggest-accept

. "$HOME/.atuin/bin/env"

# initiate atuin - bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# bun completions
[ -s "/Users/admin/.bun/_bun" ] && source "/Users/admin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
