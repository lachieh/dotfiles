#!/bin/sh
set -eo pipefail

CLAUDE_ORIGINAL_DIR="$HOME/.claude"

CLAUDE_DATA_DIR="$XDG_DATA_HOME/claude"
CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

log() {
  echo "\033[33m[300-claude.zsh]\033[0m LOG: $@"
}
err() {
  echo "\033[31m[300-claude.zsh]\033[0m ERR: $@"
}

if [ ! -d "$CLAUDE_DATA_DIR" ]; then
  log "Creating data directory at $CLAUDE_DATA_DIR"
  mkdir -p "$CLAUDE_DATA_DIR"
fi

if [ ! -d "$CLAUDE_CONFIG_DIR" ]; then
  log "Creating config directory at $CLAUDE_CONFIG_DIR"
  mkdir -p "$CLAUDE_CONFIG_DIR"
fi

# check if the data dir exists at $HOME/.claude and isn't a symlink
if [ -d "$CLAUDE_ORIGINAL_DIR" ] && [ ! -L "$CLAUDE_ORIGINAL_DIR" ]; then
  # check for contents
  FAILED_TO_MOVE=0
  if [ "$(ls -A "$CLAUDE_ORIGINAL_DIR")" ]; then
    log "Data directory already exists at $CLAUDE_ORIGINAL_DIR. Moving contents."
    FAILED_TO_MOVE=$(cp -R "$CLAUDE_ORIGINAL_DIR/*" "$CLAUDE_CONFIG_DIR" || echo 1)
    FAILED_TO_MOVE=$(cp -R "$CLAUDE_ORIGINAL_DIR/.*" "$CLAUDE_CONFIG_DIR" || echo 1)
  fi

  if [ $FAILED_TO_MOVE ]; then
    err "Some files failed to move data from $CLAUDE_ORIGINAL_DIR to $CLAUDE_CONFIG_DIR"
    log "Creating backup of old data directory at $CLAUDE_ORIGINAL_DIR.bak"
    mv "$CLAUDE_ORIGINAL_DIR" "$CLAUDE_ORIGINAL_DIR.bak"
  fi
  
  log "Creating symlink from $CLAUDE_CONFIG_DIR to $CLAUDE_ORIGINAL_DIR"
  ln -s "$CLAUDE_CONFIG_DIR" "$CLAUDE_ORIGINAL_DIR"
fi

if [ -f "$HOME/claude.json" ] && [ ! -L "$HOME/claude.json" ]; then
  log "Found claude.json at $HOME/claude.json"
  FAILED_TO_MOVE=0
  FAILED_TO_MOVE=$(cp "$HOME/claude.json" "$CLAUDE_DATA_DIR/claude.json" || echo 1)
  if [ $FAILED_TO_MOVE ]; then
    err "Failed to move claude.json to $CLAUDE_DATA_DIR. Creating backup."
    log "Creating backup of claude.json at $CLAUDE_DATA_DIR/claude.json.bak"
    mv "$HOME/claude.json" "$CLAUDE_DATA_DIR/claude.json.bak"
  fi

  log "Removing old claude.json from $HOME"
  rm "$HOME/claude.json"

  ln -s "$CLAUDE_DATA_DIR/claude.json" "$HOME/claude.json"
fi

if [[ $+commands[claude] ]]; then
  # if the claude binary is installed in the data dir, run the global install
  if [ -f "$CLAUDE_CONFIG_DIR/local/claude" ]; then
    claude install --force stable
  fi
fi
