
# Path & API keys
export OPENAI_API_BASE="https://openrouter.ai/api/v1"
export OPENROUTER_AIDER=$(cat ~/.openrouter_aider)
export OPENROUTER_API_KEY="$OPENROUTER_AIDER"
export GEMINI_API_KEY=$(cat ~/.gemini_api_key)
# export OPENAI_API_KEY="$OPENROUTER_AIDER"

# export OPENROUTER_CHATBOX=$(cat ~/.openrouter-chatbox)
# export OPENROUTER_RAYCAST=$(cat ~/.openrouter-raycast)
# export OPENROUTER_SHELL_GPT=$(cat ~/.openrouter-shell-gpt)
export OPENAI_API_KEY=$(cat ~/.openai_api_key)
# Using Claude Code CLI - no API key needed
# export ANTHROPIC_API_KEY=$(cat ~/.anthropic_api_key)
# export DEEPSEEK_API_KEY=$(cat ~/.deepseek_api_key)
#
export GITHUB_TOKEN=$(cat ~/.gh-token)

# Model
export AIDER_MODEL="openrouter/deepseek/deepseek-r1"
