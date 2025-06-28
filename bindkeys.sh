# Define the function
fzf-cd-widget() {
  local dir
  dir=$(fd --type d . | fzf --preview 'ls -la {}') || return
  BUFFER="cd $dir"
  zle accept-line
}

# Tell Zsh this is a widget
zle -N fzf-cd-widget

# Bind it to Ctrl-G
bindkey '^G' fzf-cd-widget
