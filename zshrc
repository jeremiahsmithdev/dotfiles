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
source "$HOME/dotfiles/api_keys.sh"
source "$HOME/dotfiles/fzf-git.sh/fzf-git.sh"
source "$HOME/dotfiles/ai-functions.zsh"
source "$HOME/dotfiles/keybindings.sh"

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
export PATH=~/.npm-global/bin:$PATH
alias claude="/Users/admin/.claude/local/claude"
export CLAUDE_CODE_ENABLE_PROMPT_CACHE=true
unset DISABLE_PROMPT_CACHING

# TEMP
alias cache='php bin/console cache:clear'

# # Use 'files' to launch the Files fzf widget
# files() {
#   _fzf_git_files
# }
#
# # Use 'branches' to launch the Branches fzf widget
# branches() {
#   _fzf_git_branches
# }
#
# # Use 'tags' to launch the Tags fzf widget
# tags() {
#   _fzf_git_tags
# }
#
# # Use 'remotes' to browse remotes
# remotes() {
#   _fzf_git_remotes
# }
#
# # Use 'commits' to pick a commit hash
# commits() {
#   _fzf_git_log
# }
#
# # Use 'stashes' to view stashes
# stashes() {
#   _fzf_git_stashes
# }
#
# # Use 'reflogs' to view reflog entries
# reflogs() {
#   _fzf_git_reflogs
# }
#
# # Use 'worktrees' to select a worktree
# worktrees() {
#   _fzf_git_worktrees
# }
#
# # Use 'refs' to use git for-each-ref
# refs() {
#   _fzf_git_each_ref
# }
