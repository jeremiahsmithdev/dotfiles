# open files
alias aliases='nvim ~/dotfiles/aliases.sh'
alias zshrc='nvim ~/dotfiles/zshrc'
alias init='nvim ~/.config/nvim/init.lua'
alias plugins='nvim ~/.config/nvim/lua/plugins.lua'
alias tmux.conf='nvim ~/dotfiles/tmux.conf'
alias skhdrc='nvim ~/dotfiles/skhdrc'
alias yabairc='nvim ~/dotfiles/yabairc'
alias wezterm.lua='nvim ~/dotfiles/wezterm.lua'
alias karabiner.json='nvim ~/.config/karabiner/karabiner.json'
alias zshenv='nvim ~/dotfiles/zshenv'
alias keys='nvim ~/.config/nvim/lua/keys.lua'
alias api-keys='nvim ~/dotfiles/api_keys.sh'
alias dev.md='nvim ~/dev/dev.md'

# directory navigation
alias c='cd $(find * -type d | fzf)'
alias obsidian='cd ~/Library/"Mobile Documents"/iCloud~md~obsidian/Documents/Obsidian'
alias ta='tmux attach'
alias config='cd ~/.config'
alias lua='cd ~/.config/nvim/lua'
alias dotfiles='cd ~/dotfiles'
alias dev='cd ~/dev'
alias configs='cd ~/.config/nvim/lua/config'

alias diff='nvim -c "DiffAll"'

# sgpt
alias gpt='function _gpt() { sgpt "$*"; }; _gpt'
alias shell='function _shell_gpt() { sgpt --shell "$*"; }; _shell_gpt'
alias code='function _code_gpt() { sgpt --code "$*"; }; _code_gpt'
alias chat='function _chat_gpt() { sgpt --chat 1 "$*"; }; _chat_gpt'

# general
alias lg='lazygit'
alias ex='exec zsh'
# alias q='exit'
alias tmux-refresh='tmux source-file ~/.tmux.conf; tmux refresh-client -S'
alias gl='git log --oneline'

# SSH
alias ssh-zulip='ssh -i /Users/admin/.ssh/js-ssh-key root@tt.privsec.vip'
alias ssh-test-1='ssh -i ~/.ssh/js-ssh-key root@45.77.238.66'
alias ssh-test-2='ssh -i ~/.ssh/js-ssh-key root@45.32.247.49'
alias ssh-test-3='ssh -i ~/.ssh/js-ssh-key root@149.28.172.229'
alias ssh-droplet='ssh -i ~/.ssh/js-ssh-key root@209.38.27.69'

# notes
alias gh-token='cat ~/.gh-token'

# copy to clipboard
alias number-india='printf "7302499114" | pbcopy'


# git
alias checkout='git checkout $(git log --oneline | fzf | awk '"'"'{print $1}'"'"')'
alias set-default='gh repo set-default jeremiahsmithdev/$(basename $(git rev-parse --show-toplevel))'
alias diff='nvim $(git diff --name-only HEAD) -c "Gdiff"'
alias diff='nvim $(git diff --name-only HEAD) -c "DiffviewOpen"'

# MiroTalk
alias update-c2c='~/dev/PrivSecure/mirotalk/update-c2c.sh'
alias update-p2p='~/dev/PrivSecure/mirotalk/update-p2p.sh'
alias update-sfu='~/dev/PrivSecure/mirotalk/update-sfu.sh'

# AI
alias rovo='acli rovodev run'
