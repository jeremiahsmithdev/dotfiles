# ╭───────────────────────────────────────────╮
# │             CORE CONFIGURATION            │
# ╰───────────────────────────────────────────╯
source ~/dotfiles/zshenv
source ~/dotfiles/omz.zsh
source ~/dotfiles/aliases.zsh
source ~/dotfiles/dynamic_cursor.zsh
source ~/dotfiles/keybindings.sh
source ~/dotfiles/api_keys.sh
source ~/dotfiles/keybindings.sh

export ZSH="$HOME/.oh-my-zsh"
export AIDER_EDITOR=nvim

# plugins=(git zsh-autosuggestions)


export EDITOR=nvim

# theme
autoload -U promptinit; promptinit
prompt pure

# ╭───────────────────────────────────────────╮
# │                PLUGINS & TOOLS            │
# ╰───────────────────────────────────────────╯

 . $(brew --prefix)/etc/profile.d/z.sh

#  # zsh-autosuggestions
# source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
# ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

. "$HOME/.atuin/bin/env"

# initiate atuin - bind ctrl-r but not up arrow
eval "$(atuin init zsh --disable-up-arrow)"

# bun completions
[ -s "/Users/admin/.bun/_bun" ] && source "/Users/admin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ╭───────────────────────────────────────────╮
# │                 FUNCTIONS                 │
# ╰───────────────────────────────────────────╯

# Auto set the default repo for use with 'gh browse' cmd
ghb() {
  gh repo set-default "$(git config --get remote.origin.url)" >/dev/null 2>&1
  gh browse "$@"
}

# bindkey '^F' fzf_nvim_preview
# bindkey '^E' autosuggest-accept
# source ~/dotfiles/keybindings.sh
