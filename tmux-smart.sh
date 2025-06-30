#!/bin/bash

while true; do
  # If a session exists, attach to the most recently used one
  if tmux has-session 2>/dev/null; then
    tmux attach-session -t "$(tmux list-sessions -F '#{session_name}' | head -n 1)"
  else
    tmux new-session
  fi

  # When tmux exits, wait for a brief moment then loop back
  echo "tmux exited. Press Ctrl+C to close, or wait to reconnect..."
  sleep 2
done
