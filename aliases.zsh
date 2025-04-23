# open files
alias aliases='nvim ~/dotfiles/aliases.zsh'
alias zshrc='nvim ~/dotfiles/zshrc'
alias init='nvim ~/.config/nvim/init.lua'
alias plugins='nvim ~/.config/nvim/lua/plugins.lua'
alias tmux.conf='nvim ~/dotfiles/tmux.conf'
alias skhdrc='nvim ~/dotfiles/skhdrc'
alias yabairc='nvim ~/dotfiles/yabairc'
alias wezterm.lua='nvim ~/dotfiles/wezterm.lua'
alias karabiner.json='nvim ~/.config/karabiner/karabiner.json'
alias zshenv='nvim ~/dotfiles/zshenv'

# directory navigation
alias c='cd $(find * -type d | fzf)'
alias obsidian='cd ~/Library/"Mobile Documents"/iCloud~md~obsidian/Documents/Obsidian'
alias ta='tmux attach'
alias config='cd ~/.config'
alias lua='cd ~/.config/nvim/lua'
alias dotfiles='cd ~/dotfiles'
alias dev='cd ~/dev'

# sgpt
alias gpt='function _gpt() { sgpt "$*"; }; _gpt'
alias shell='function _shell_gpt() { sgpt --shell "$*"; }; _shell_gpt'
alias code='function _code_gpt() { sgpt --code "$*"; }; _code_gpt'
alias chat='function _chat_gpt() { sgpt --chat 1 "$*"; }; _chat_gpt'

# general
alias lg='lazygit'
alias ex='exec zsh'
