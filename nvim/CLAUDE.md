# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Architecture Overview

This is a heavily customized **Kickstart.nvim** configuration using **lazy.nvim** as the plugin manager. The config follows a modular architecture with 70+ plugins and clear separation of concerns.

### Key Structure
- `init.lua` - Main entry point and loading sequence
- `lua/plugins.lua` - Primary plugin definitions (preferred)
- `lua/lazy.lua` - Alternative plugin setup (legacy from kickstart template)
- `lua/config/` - Individual plugin configurations
- `lua/custom/` - Custom extensions and utilities
- `lazy-lock.json` - Plugin version lockfile for reproducible builds

### Loading Order
1. `plugins.lua` - Install all plugins first
2. `keys.lua` - Personal keybindings
3. `style.lua` - Colorscheme and UI setup
4. `opts.lua` - Editor options
5. `autocmds.lua` - Autocommands
6. `functions.lua` - Custom utility functions
7. Individual plugin configs from `config/` directory

## Plugin Management

### Adding New Plugins
- **Primary method**: Add to `lua/plugins.lua` with proper lazy loading
- Use lazy loading patterns: `event`, `cmd`, `ft`, `keys` for performance
- Complex plugins get separate config files in `lua/config/`
- Simple plugins can be configured inline within the plugin spec

### Plugin Categories
- **Development**: LSP (Mason), DAP debugging, completion (nvim-cmp), AI assistance (CodeCompanion, Codeium, Avante)
- **Navigation**: Telescope (with fzf), nvim-tree, neo-tree, Leap.nvim
- **Git**: Gitsigns, Fugitive, Diffview, LazyGit integration
- **UI**: Lualine statusline, Gruvbox theme, Noice notifications, Alpha dashboard
- **Productivity**: doing.nvim tasks, TODO comments, Markdown preview, HTTP client

## Development Workflow

### Language Server Setup
- **Mason** handles automatic LSP installation
- Configure new language servers in `lua/language-servers.lua`
- LSP diagnostic symbols are customized with icons in `init.lua:96-105`

### Debugging
- **DAP** (Debug Adapter Protocol) with UI configured
- Key bindings: `<F5>` continue, `<F10>` step over, `<F11>` step into, `<F12>` step out
- `<Leader>b` toggle breakpoint, `<Leader>du/dc/dt` for DAP UI open/close/toggle

### AI Integration
- Multiple AI assistants available: CodeCompanion, Codeium, Avante
- Image clipboard integration for AI chats
- Markdown rendering in AI chat buffers

### Testing & Linting
- No specific test framework configured - check project README for testing commands
- No built-in linting commands - verify project-specific lint commands before making changes

## Key Bindings Architecture

### Leader Key
- `<Space>` is the leader key (`vim.g.mapleader = ' '`)

### Keybinding Patterns
- **Custom helper**: `lua/binds.lua` provides `Bind()` function for easier keymap creation
- **Plugin-specific**: Individual config files contain relevant keymaps
- **Global personal**: `lua/keys.lua` for user-specific bindings
- **Smart-splits integration**: `<C-hjkl>` for navigation, `<A-hjkl>` for resizing, `<A-HJKL>` for swapping

### Common Mappings
- `<leader>xt` - Todo Telescope
- `<leader>du/dc/dt` - DAP UI control
- Navigation via smart-splits for tmux/yabai integration

## Configuration Patterns

### Custom Functions
- Located in `lua/functions.lua`
- Includes bedtime notifications (after 10 PM reminder)
- Custom command creation helpers

### Environment Integration
- **macOS specific**: Yabai window manager integration via smart-splits
- **Browser integration**: Firenvim for browser-based editing
- **Clipboard**: System clipboard integration configured

### File Type Detection
- Custom filetype: `skhdrc` files detected as shell scripts (`init.lua:107-111`)

## TODO System

The config uses an active TODO/task system:
- Built-in `doing.nvim` for personal task management
- TODO comments highlighted and searchable via `<leader>xt`
- `.tasks` files in lua directories for development tasks

## Theme & UI

- **Colorscheme**: Gruvbox with transparency support
- **Statusline**: Lualine with GPS integration for code context
- **Notifications**: Noice.nvim + nvim-notify with custom background
- **Dashboard**: Alpha.nvim welcome screen
- **Smooth scrolling**: Neoscroll configured

## Performance Considerations

- Extensive use of lazy loading for startup performance
- Conditional loading based on file types and events
- Plugin count managed via lazy-lock.json for reproducible builds
- Smart completion setup with multiple sources (LSP, snippets, paths)

## Working with This Config

1. **Plugin changes**: Prefer `plugins.lua` over `lazy.lua`
2. **Keybindings**: Use `Bind()` helper or add to appropriate config files
3. **LSP additions**: Configure in `language-servers.lua`
4. **Theme changes**: Modify `style.lua`
5. **Editor options**: Add to `opts.lua`
6. **Custom utilities**: Add to `functions.lua`

## Migration Notes

The configuration is in active migration from an older setup:
- TODOs indicate pending migrations and improvements
- Dual plugin files (`plugins.lua` vs `lazy.lua`) exist during transition
- Some require statements in `init.lua` may be consolidated into plugin specs