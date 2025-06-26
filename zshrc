# ╭───────────────────────────────────────────╮
# │           ENVIRONMENT VARIABLES           │
# ╰───────────────────────────────────────────╯
export ZSH="$HOME/.oh-my-zsh"
export EDITOR=nvim
export AIDER_EDITOR=nvim
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ╭───────────────────────────────────────────╮
# │              SOURCING FILES               │
# ╰───────────────────────────────────────────╯
# Source personal configuration files
source "$HOME/dotfiles/zshenv"
source "$HOME/dotfiles/omz.zsh"
source "$HOME/dotfiles/aliases.sh"
source "$HOME/dotfiles/dynamic_cursor.zsh"
source "$HOME/dotfiles/keybindings.sh"
source "$HOME/dotfiles/api_keys.sh"

# ╭───────────────────────────────────────────╮
# │                 SHELL THEME               │
# ╰───────────────────────────────────────────╯
autoload -U promptinit; promptinit
prompt pure

# ╭───────────────────────────────────────────╮
# │                PLUGINS & TOOLS            │
# ╰───────────────────────────────────────────╯

# Atuin - Shell History
[ -s "$HOME/.atuin/bin/env" ] && source "$HOME/.atuin/bin/env"
eval "$(atuin init zsh --disable-up-arrow)"

# Z - Directory Jumper
[ -f "$(brew --prefix)/etc/profile.d/z.sh" ] && . "$(brew --prefix)/etc/profile.d/z.sh"

# Bun - Completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"


# ╭───────────────────────────────────────────╮
# │                 FUNCTIONS                 │
# ╰───────────────────────────────────────────╯

# ghb() - Open current repo in GitHub
# Auto sets the default repo for use with 'gh browse'
ghb() {
  gh repo set-default "$(git config --get remote.origin.url)" >/dev/null 2>&1
  gh browse "$@"
}
