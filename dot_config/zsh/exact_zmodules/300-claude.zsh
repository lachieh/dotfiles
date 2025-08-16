#!/bin/sh
set -eo pipefail

CLAUDE_ORIGINAL_DIR="$HOME/.claude"
CLAUDE_LOCAL_BIN="$HOME/.claude/local"
CLAUDE_NATIVE_BIN="$HOME/.local/bin/claude"

CLAUDE_DATA_DIR="$XDG_DATA_HOME/claude"
CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

log() {
  echo "300-claude.zsh \e[33m[LOG]\e[0m $@"
}
err() {
  echo "300-claude.zsh \e[31m[ERR]\e[0m $@"
}
file_exists() { [ -e "$1" ] }
file_is_symlink() { [ -L "$1" ] }

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
    log "Data directory already exists at $CLAUDE_ORIGINAL_DIR. Moving contents to $CLAUDE_CONFIG_DIR."
    FAILED_TO_MOVE=$(rsync -a --delete "$CLAUDE_CONFIG_DIR"/ "$CLAUDE_ORIGINAL_DIR"/)
    if [ $FAILED_TO_MOVE ]; then
      err "Failed to sync $CLAUDE_CONFIG_DIR to $CLAUDE_ORIGINAL_DIR"
      log "Creating backup of old data directory at $CLAUDE_ORIGINAL_DIR.bak"
      mv "$CLAUDE_ORIGINAL_DIR" "$CLAUDE_ORIGINAL_DIR.bak"
    fi
  fi
  
  log "Creating symlink from $CLAUDE_CONFIG_DIR to $CLAUDE_ORIGINAL_DIR"
  ln -s "$CLAUDE_CONFIG_DIR" "$CLAUDE_ORIGINAL_DIR"
fi

if [ -f "$HOME/claude.json" ] && [ ! -L "$HOME/claude.json" ]; then
  log "Found claude.json at $HOME/claude.json"

  FAILED_TO_MOVE=0
  FAILED_TO_MOVE="$(cp "$HOME"/.claude.json "$CLAUDE_DATA_DIR"/claude.json || echo 1)"

  if [ $FAILED_TO_MOVE ]; then
    err "Failed to move claude.json to $CLAUDE_DATA_DIR. Creating backup."
    log "Creating backup of claude.json at $CLAUDE_DATA_DIR/claude.json.bak"
    mv "$HOME/claude.json" "$CLAUDE_DATA_DIR/claude.json.bak"
  fi

  log "Removing old claude.json from $HOME"
  rm "$HOME/claude.json"
fi

if [ ! -L "$HOME/claude.json" ]; then
  ln -s "$CLAUDE_DATA_DIR/claude.json" "$HOME/claude.json"
fi

if [ -f $CLAUDE_LOCAL_BIN ]; then
  log "Found claude binary at $CLAUDE_LOCAL_BIN. Removing."
  rm -rf "$CLAUDE_LOCAL_BIN"
fi

export PATH="$CLAUDE_NATIVE_BIN:$PATH"

if [[ ! $+commands[claude] ]]; then
  log "No binary for claude found. Install it into $CLAUDE_NATIVE_BIN"
else
  # if the claude binary is installed in the data dir, run the global install
  if [ -f "$CLAUDE_CONFIG_DIR/local/claude" ]; then
    claude install --force stable
  fi
fi

set +eo pipefail
