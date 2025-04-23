source ~/dotfiles/zshenv
source ~/dotfiles/omz.zsh
source ~/dotfiles/aliases.zsh
source ~/dotfiles/dynamic_cursor.zsh
source ~/dotfiles/fzf_nvim_preview.zsh

export ZSH="$HOME/.oh-my-zsh"

plugins=(git zsh-autosuggestions)

# enable vim mode
bindkey -v

# Path & API keys
export OPENAI_API_KEY=$(cat ~/.openai_api_key)

# theme
autoload -U promptinit; promptinit
prompt pure

bindkey '^F' fzf_nvim_preview

 . $(brew --prefix)/etc/profile.d/z.sh

 # zsh-autosuggestions
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
bindkey '^E' autosuggest-accept
