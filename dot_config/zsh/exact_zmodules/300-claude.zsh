#!/bin/sh
set -eo pipefail

CLAUDE_ORIGINAL_DIR="$HOME/.claude"

CLAUDE_DATA_DIR="$XDG_DATA_HOME/claude"
CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude"

# check if folder exists at $XDG_DATA_HOME
if [ ! -d "$CLAUDE_DATA_DIR" ]; then
  echo "Creating data directory at $CLAUDE_DATA_DIR"
  mkdir -p "$CLAUDE_DATA_DIR"
fi

# check if the data dir exists at $HOME/.claude and link from $XDG_DATA_HOME
if [ -d "$CLAUDE_ORIGINAL_DIR" ]; then
  # check for contents
  FAILED_TO_MOVE=0
  if [ "$(ls -A "$CLAUDE_ORIGINAL_DIR")" ]; then
    echo "Data directory already exists at $CLAUDE_ORIGINAL_DIR. Moving contents."
    FAILED_TO_MOVE=$(cp "$CLAUDE_ORIGINAL_DIR/*" "$CLAUDE_DATA_DIR" || echo 1)
    FAILED_TO_MOVE=$(cp "$CLAUDE_ORIGINAL_DIR/.*" "$CLAUDE_DATA_DIR" || echo 1)
  fi

  if [ $FAILED_TO_MOVE ]; then
    echo "Some files failed to move."
    echo "Creating backup of old data directory at $CLAUDE_ORIGINAL_DIR"
    mv "$CLAUDE_ORIGINAL_DIR" "$CLAUDE_ORIGINAL_DIR.bak"
  fi

  echo "Creating symlink from \$XDG_DATA_HOME/.claude to \$CLAUDE_ORIGINAL_DIR"
  ln -s "$XDG_DATA_HOME/.claude" "$CLAUDE_ORIGINAL_DIR"
fi

if [[ $+commands[claude] ]]; then
  # if the claude binary is installed in the data dir, run the global install
  if [ -f "$CLAUDE_DATA_DIR/local/claude" ]; then
    claude install --force stable
  fi
fi
