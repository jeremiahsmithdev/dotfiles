source ~/.omz.zsh
source ~/.aliases.zsh
source ~/.dynamic_cursor.zsh
source ~/.zshenv

plugins=(git zsh-autosuggestions)

# enable vim mode
bindkey -v

alias c='cd $(find * -type d | fzf)'

# Path & API keys
export OPENAI_API_KEY=
export PATH="$HOME/bin:$PATH"
export PATH=$HOME/bin/nvim-macos/bin:$PATH

# theme
# .zshrc
autoload -U promptinit; promptinit
prompt pure

bindkey -s ^F "fzf --bind 'enter:become(nvim {})' --preview 'bat --style=numbers --color=always {}'\015"

 . $(brew --prefix)/etc/profile.d/z.sh

 # zsh-autosuggestions
source /usr/local/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'
bindkey '^E' autosuggest-accept
