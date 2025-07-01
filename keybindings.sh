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

fzf_git_preview() {
  local file
  file=$(_fzf_git_files)
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
  zle reset-prompt
}
zle -N fzf_git_preview

# Unified widget: tries git preview first, falls back to normal preview if not in git repo
fzf_file_widget() {
  if git rev-parse --is-inside-work-tree &>/dev/null; then
    fzf_git_preview
  else
    fzf_nvim_preview
  fi
}
zle -N fzf_file_widget

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

# Find files: ctrl-f tries git widget, falls back on non-git
bindkey '^F' fzf_file_widget

bindkey '^E' autosuggest-accept

