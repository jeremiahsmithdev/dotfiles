# ╭───────────────────────────────────────────╮
# │               FUNCTIONS                   │
# ╰───────────────────────────────────────────╯

 # zsh-autosuggestions
source ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=242'

# Find files in the current directory
fzf_nvim_preview() {
  local file
  file=$(find . -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {}')
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
  zle reset-prompt
}
zle -N fzf_nvim_preview

# Find directories in the current directory
fzf-cd-widget() {
  local dir
  dir=$(fd --type d . | fzf --preview 'ls -la {}') || return
  BUFFER="cd $dir"
  zle accept-line
}
zle -N fzf-cd-widget # Tell Zsh this is a widget

# ╭───────────────────────────────────────────╮
# │                BINDINGS                   │
# ╰───────────────────────────────────────────╯

# Set vi mode BEFORE defining any keybindings
bindkey -v

# Find directories mapping
bindkey '^G' fzf-cd-widget

# Find files binding
bindkey '^F' fzf_nvim_preview

bindkey '^E' autosuggest-accept
