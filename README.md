# Dotfiles

Personal configuration files for macOS development environment.

## What's included

- **Neovim**: Modern text editor with modular plugin system, AI integrations, and debugging support
- **Zsh**: Shell configuration with aliases, functions, and keybindings
- **Git**: Version control settings and aliases
- **Window management**: Yabai (tiling) and SKHD (hotkeys) for efficient workspace navigation
- **Tmux**: Terminal multiplexer for session management
- **Karabiner**: Keyboard customization for macOS

## Key Features

- **Auto-discovering plugin system**: Neovim plugins are automatically loaded from individual files
- **AI code assistance**: Multiple AI tools integrated (CodeCompanion, Claude Code, etc.)
- **Unified file navigation**: Smart FZF integration for git and regular file browsing
- **TODO workflow**: Specialized markdown handling for task management
- **Debug support**: DAP debugging configuration for multiple languages

## Installation

Symlink the configuration files to your home directory:

```bash
# Core configs
ln -sf ~/dotfiles/zshrc ~/.zshrc
ln -sf ~/dotfiles/gitconfig ~/.gitconfig
ln -sf ~/dotfiles/tmux.conf ~/.tmux.conf

# ~/.config directory
ln -sf ~/dotfiles/nvim ~/.config/nvim
ln -sf ~/dotfiles/karabiner ~/.config/karabiner
ln -sf ~/dotfiles/yabairc ~/.config/yabai/yabairc
ln -sf ~/dotfiles/skhdrc ~/.config/skhd/skhdrc
```
