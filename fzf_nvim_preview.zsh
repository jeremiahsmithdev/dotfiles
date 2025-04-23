fzf_nvim_preview() {
  local file
  file=$(find . -type f 2> /dev/null | fzf --preview 'bat --style=numbers --color=always {}')
  if [[ -n "$file" ]]; then
    nvim "$file"
  fi
  zle reset-prompt
}
zle -N fzf_nvim_preview
bindkey '^F' fzf_nvim_preview
