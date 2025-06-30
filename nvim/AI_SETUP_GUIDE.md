# AI-Driven Neovim Workflow Setup Guide

## Quick Start

### 1. Prerequisites
Ensure you have the following installed:
- **Neovim 0.9+**
- **Node.js 18+** (for MCP servers)
- **Claude CLI** (configured with API key)
- **Git** (for context gathering)
- **fzf** (for fuzzy finding)
- **bat** (for file previews)
- **tree** (for project structure)

### 2. Installation
The optimized configuration is already set up. To activate the AI workflow:

```bash
# Reload your shell configuration
source ~/.zshrc

# Reload tmux configuration
tmux source-file ~/.tmux.conf

# Restart Neovim to load new plugins
nvim
```

### 3. Verify Installation
Test the AI workflow components:

```bash
# Test AI functions
aic --help     # AI commit (should show usage)
aip            # AI project analysis
ais            # Smart AI suggestions

# Test in Neovim
nvim
:AIModeInfo    # Should show current AI mode
<leader>am     # Cycle through AI modes
```

## AI Modes Overview

### 1. Manual Mode (✋)
- **Default mode**: Full manual control
- **Use case**: When you want complete control
- **Keybindings**: Standard Neovim keybindings only

### 2. AI Assist Mode (🤝)
- **On-demand AI**: AI suggestions when requested
- **Use case**: Occasional AI help
- **Key trigger**: `<leader><CR>` for AI actions

### 3. AI Pair Mode (👥)
- **Active pairing**: AI suggestions and explanations
- **Use case**: Collaborative development with AI
- **Key triggers**: 
  - `<CR>` for AI actions
  - `<Tab>` for suggestions
  - `?` for explanations

### 4. AI Autonomous Mode (🤖)
- **AI-driven**: Proactive AI assistance
- **Use case**: AI-guided development
- **Key triggers**:
  - `<CR>` for autonomous actions
  - `<Space>` to continue AI tasks

## Key Bindings Reference

### AI Mode Management
- `<leader>am` - Cycle through AI modes
- `<leader>a1` - Switch to Manual mode
- `<leader>a2` - Switch to AI Assist mode
- `<leader>a3` - Switch to AI Pair mode
- `<leader>a4` - Switch to AI Autonomous mode

### AI Actions
- `<leader>cc` - CodeCompanion Actions
- `<leader>ct` - Toggle CodeCompanion Chat
- `<leader>ca` - Add selection to CodeCompanion
- `<leader>aa` - Avante Ask
- `<leader>ae` - Avante Edit
- `<leader>ar` - Avante Refresh
- `<leader>ap` - Select AI Provider

### MCP Integration
- `<leader>mc` - MCP Connect
- `<leader>ml` - MCP List Servers
- `<leader>ms` - MCP Status

### AI Shell Integration
- `<leader>gc` - AI Git Commit
- `<leader>ge` - AI Explain Command
- `<leader>gd` - AI Debug Error
- `<leader>gf` - AI Edit File
- `<leader>ga` - AI Analyze Project
- `<leader>mf` - AI File Analysis (FZF)
- `<leader>mb` - AI Branch Analysis (FZF)

### Session Management
- `<leader>qs` - Restore Session
- `<leader>ql` - Restore Last Session
- `<leader>qd` - Don't Save Current Session

## Shell Commands Reference

### AI Development Workflow
```bash
# Git workflow
aic              # AI-powered git commit
gaic             # Stage all files and AI commit
air              # AI code review for staged changes
gair             # Stage all and AI review

# File and project analysis
aie              # AI-powered file editing
aip              # Analyze entire project
aif              # AI file analysis with FZF
aib              # AI branch analysis with FZF

# Code improvement
ait              # Generate tests for file
aid              # Generate documentation
airf             # Refactoring suggestions
ais              # Smart context-aware suggestions

# Debugging and explanation
exp              # Explain last command
dbg              # Debug last error
ach              # Start AI chat session
```

### Tmux AI Integration
```bash
# In tmux, use prefix key followed by:
A                # Open AI chat window
C-a              # Split with AI code assistant
M-a              # AI chat popup
G                # Git context browser
F                # File context browser
P                # Project analysis
R                # Review terminal output
E                # Explain terminal session
C-g              # AI commit workflow
C-e              # Context-aware file editing
S                # Smart AI suggestions
```

## Workflow Examples

### 1. AI-Assisted Development
```bash
# Start a new feature
cd my-project
aip                           # Analyze project context
nvim src/feature.py          # Open file
<leader>a3                   # Switch to AI Pair mode
# Now <CR> triggers AI actions, <Tab> gives suggestions

# When ready to commit
aic                          # AI generates commit message
```

### 2. Debugging Workflow
```bash
# When encountering an error
npm test                     # Command fails
dbg                          # AI analyzes the error
nvim src/broken-file.js      # Open problematic file
<leader>cc                   # Get AI suggestions
```

### 3. Code Review Workflow
```bash
# Before committing changes
git add .                    # Stage changes
air                          # AI reviews staged changes
# Make improvements based on AI feedback
aic                          # AI generates commit message
```

### 4. Project Exploration
```bash
# Understanding a new codebase
cd new-project
aip                          # Get AI project overview
aif                          # Analyze key files with AI
aib                          # Understand git history
```

## Configuration Customization

### Adjusting AI Providers

#### Dynamic Provider Switching
```bash
# In Neovim
<leader>ap                   # Select provider interactively
:AISwitchProvider claude     # Switch to Claude
:AISwitchProvider openai     # Switch to OpenAI
:AISwitchProvider ollama     # Switch to local Ollama
```

#### Configuration
Edit `~/.config/nvim/lua/config/ai-unified.lua`:

```lua
M.providers = {
  primary = "claude_cli",    -- Using Claude Code CLI
  fallback = "openai",       -- Backup provider
  ["local"] = "ollama",      -- Local model (note the quotes for "local")
  completion = "codeium",    -- Code completion
}

-- Provider configurations (updated format)
M.provider_configs = {
  claude_cli = {
    -- Claude CLI configuration
    command = "claude",
    args = function(prompt)
      return { prompt }
    end,
  },
  claude = {
    endpoint = "https://api.anthropic.com",
    model = "claude-3-5-sonnet-20241022",
    extra = {
      temperature = 0,
    },
    extra_request_body = {
      max_tokens = 8192,
    },
  },
  openai = {
    endpoint = "https://api.openai.com/v1", 
    model = "gpt-4o",
    extra = {
      temperature = 0.1,
    },
    extra_request_body = {
      max_tokens = 4096,
    },
  },
  ollama = {
    endpoint = "http://127.0.0.1:11434/v1",
    model = "codellama:13b", 
    extra = {
      temperature = 0.2,
    },
    extra_request_body = {
      max_tokens = 2048,
    },
  },
}
```

### Customizing AI Models
```lua
M.models = {
  claude = "claude-3-5-sonnet-20241022",  -- Latest Claude model
  openai = "gpt-4o",                      -- Latest GPT model
  ollama = "codellama:13b",               # Local model
}
```

### Adding Custom AI Functions
Add to `~/dotfiles/ai-functions.zsh`:

```bash
# Custom AI function example
my_ai_function() {
  local input="$1"
  echo "$input" | claude "Your custom prompt here"
}
```

## Troubleshooting

### Common Issues

1. **Avante provider deprecation warnings**
   ```
   [DEPRECATED] The configuration of `claude` should be placed in `providers.claude`
   [DEPRECATED] The configuration of providers.claude.temperature should be placed in providers.claude.extra
   [DEPRECATED] The configuration of providers.claude.max_tokens should be placed in providers.claude.extra_request_body.max_tokens
   ```
   **Solution**: These have been fixed in the updated configuration. The provider config now uses:
   - New `providers.claude` format instead of `claude`
   - Temperature settings in `providers.claude.extra.temperature` instead of `providers.claude.temperature`
   - Max tokens in `providers.claude.extra_request_body.max_tokens` instead of `providers.claude.max_tokens`

2. **Lua syntax error with 'local' keyword**
   ```
   unexpected symbol near 'local'
   ```
   **Solution**: Fixed by using `["local"]` instead of `local` as a table key (local is a reserved keyword)

3. **Claude Code CLI Integration**
   This configuration is optimized to work with Claude Code CLI, which doesn't require an API key.
   
   **Verification**: Check that Claude CLI is working:
   ```bash
   claude --version
   ```
   
   If you prefer to use the API instead of Claude CLI, uncomment this line in `~/dotfiles/api_keys.sh`:
   ```bash
   # export ANTHROPIC_API_KEY=$(cat ~/.anthropic_api_key)
   ```

4. **AI functions not found**
   ```bash
   source ~/dotfiles/ai-functions.zsh
   ```

5. **Claude CLI not working**
   ```bash
   claude --version
   # If not found, install Claude CLI
   ```

6. **MCP servers not connecting**
   ```bash
   npm install -g @modelcontextprotocol/server-filesystem
   npm install -g @modelcontextprotocol/server-git
   ```

7. **Tmux AI bindings not working**
   ```bash
   tmux source-file ~/.tmux.conf
   ```

8. **Provider switching not working**
   ```bash
   # Check available providers
   :lua print(vim.inspect(require('config.ai-unified').get_available_providers()))
   ```

### Performance Issues

1. **Slow AI responses**
   - Check internet connection
   - Verify API keys are set
   - Consider using local models for faster responses

2. **High memory usage**
   - Disable AI mode when not needed: `<leader>a1`
   - Reduce context size in configurations

### Debug Mode
Enable debug logging:

```bash
export AI_DEBUG=1
nvim
```

## Advanced Usage

### Custom MCP Servers
Add custom MCP servers in `~/.config/nvim/lua/plugins.lua`:

```lua
servers = {
  custom_server = {
    command = "node",
    args = { "/path/to/your/mcp-server.js" },
    env = { CUSTOM_API_KEY = os.getenv("CUSTOM_API_KEY") },
  },
}
```

### AI Workflow Automation
Create custom automation scripts:

```bash
# Auto-commit with AI every hour
echo "0 * * * * cd /path/to/project && git add . && aic" | crontab -
```

### Integration with Other Tools
- **VS Code**: Use the same AI functions in VS Code terminal
- **JetBrains**: Configure external tools to use AI functions
- **Vim**: Basic compatibility with the shell functions

## Best Practices

### 1. Context Management
- Keep project structure clean for better AI understanding
- Use meaningful commit messages (AI learns from them)
- Maintain good documentation (AI uses it for context)

### 2. AI Mode Usage
- Start with AI Assist mode for new projects
- Use AI Pair mode for complex development
- Reserve Autonomous mode for well-understood tasks

### 3. Security Considerations
- Never commit API keys to version control
- Review AI-generated code before committing
- Use local models for sensitive projects

### 4. Performance Optimization
- Use lazy loading for AI features
- Cache AI responses when possible
- Prefer local models for simple tasks

## Support and Updates

### Getting Help
1. Check `:help` in Neovim for plugin documentation
2. Use `<leader>ac` to show current AI context
3. Run `:AIModeInfo` to see current mode details

### Staying Updated
```bash
# Update Neovim plugins
nvim -c "Lazy update"

# Update MCP servers
npm update -g @modelcontextprotocol/server-*

# Update AI functions
cd ~/dotfiles && git pull
```

This AI-driven workflow transforms your development environment into an intelligent, context-aware system that seamlessly blends manual control with AI assistance, following Unix philosophy principles while providing cutting-edge AI capabilities.