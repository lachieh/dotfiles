#!/usr/bin/env zsh
set -eo pipefail

# moltbot config
if [ -x "$(command -v moltbot)" ]; then
  if [ -e "$HOME/.moltbot" ] && [ ! -L "$HOME/.moltbot" ]; then
    mv "$HOME/.moltbot" "$XDG_CONFIG_HOME/moltbot"
    ln -s "$XDG_CONFIG_HOME/moltbot" "$HOME/.moltbot"
  fi
  
  if [ -e "$HOME/.clawdbot" ] && [ ! -L "$HOME/.clawdbot" ]; then
    mv "$HOME/.clawdbot/*" "$XDG_CONFIG_HOME/moltbot"
  fi

  export MOLTBOT_STATE_DIR="$XDG_CONFIG_HOME/moltbot"
  export CLAWDBOT_STATE_DIR="$MOLTBOT_STATE_DIR"
fi