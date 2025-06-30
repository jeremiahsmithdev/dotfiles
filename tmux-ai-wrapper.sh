#!/bin/bash
# Tmux AI Wrapper Script
# This script sources the AI functions and executes the requested command
# Usage: tmux-ai-wrapper.sh <function_name> [args...]

# Source the AI functions
source ~/dotfiles/ai-functions.zsh

# Execute the requested function with all arguments
"$@"