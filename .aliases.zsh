alias nvim='~/bin/nvim-macos/bin/nvim'

# open files
alias aliases='nvim ~/.aliases.zsh'
alias zshrc='nvim ~/.zshrc'
alias init='nvim ~/.config/nvim/init.lua'
alias ex='exec zsh'
alias plugins='nvim ~/.config/nvim/lua/plugins.lua'
alias tmux.conf='nvim ~/.tmux.conf'
alias skhdrc='nvim ~/.skhdrc'

# directory navigation
alias obsidian='cd ~/Library/"Mobile Documents"/iCloud~md~obsidian/Documents/Obsidian'
alias ta='tmux attach'

# sgpt
 alias gpt='function _gpt() { sgpt "$*"; }; _gpt'
 alias shell='function _shell_gpt() { sgpt --shell "$*"; }; _shell_gpt'
 alias code='function _code_gpt() { sgpt --code "$*"; }; _code_gpt'
 alias chat='function _chat_gpt() { sgpt --chat 1 "$*"; }; _chat_gpt'
