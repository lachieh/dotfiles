#!/usr/bin/env zsh
set -eo pipefail

CLAUD_PLUGIN_DEBUG=${CLAUD_PLUGIN_DEBUG:-false}

log() {
  if [ "$CLAUD_PLUGIN_DEBUG" = "true" ]; then
    printf "300-claude.zsh \e[33m[LOG]\e[0m %s\n" "$@";
  else
    log() { :; }
  fi
}
err() { printf "300-claude.zsh \e[31m[ERR]\e[0m %s\n" "$@"; }
file_exists() { [ -e "$1" ]; }
folder_exists() { [ -d "$1" ]; }
file_is_symlink() { [ -L "$1" ]; }

# Cannot continue if claude is not installed
if [[ ! ${+commands[claude]} ]]; then
  CLAUD_PLUGIN_DEBUG=true
  log "No binary for claude found. Install it with"
  log "curl -fsSL https://claude.ai/install.sh | bash"
  return 0
fi

# if xdg folders are not set, exit
if [ -z "$XDG_DATA_HOME" ] || [ -z "$XDG_CONFIG_HOME" ] || [ -z "$XDG_STATE_HOME" ]; then
  echo "Cannot setup path links for claude:"
  echo "    \$XDG_DATA_HOME: ${XDG_DATA_HOME:-'not set'}"
  echo "    \$XDG_CONFIG_HOME: ${XDG_CONFIG_HOME:-'not set'}"
  echo "    \$XDG_STATE_HOME: ${XDG_STATE_HOME:-'not set'}"
  return 0
fi

handle_file() {
  local src_file="$1"
  local dest_file="$2"
  local backup_suffix="${3:-.bak}"

  # Create backup if source file exists and is not a symlink
  if file_exists "$src_file" && ! file_is_symlink "$src_file"; then
    log "Backing up $src_file to $src_file$backup_suffix"
    mv "$src_file" "$src_file$backup_suffix"
    log "Creating symlink: $src_file -> $dest_file"
    ln -s "$dest_file" "$src_file"
  fi
}

handle_folder() {
  local src_folder="$1"
  local dest_folder="$2"

  # Create folder if it doesn't exist
  if ! folder_exists "$dest_folder"; then
    log "Creating folder: $dest_folder"
    mkdir -p "$dest_folder"
  fi

  if folder_exists "$src_folder" && ! file_is_symlink "$src_folder"; then
    if [ "$(ls -A "$src_folder")" ]; then
      log "Moving contents from $src_folder to $dest_folder"
      cp -R "$src_folder"/* "$dest_folder" 2>/dev/null || true
    fi
    log "Creating symlink: $src_folder -> $dest_folder"
    rm -rf "$src_folder"
    ln -s "$dest_folder" "$src_folder"
  fi
}

CLAUDE_ALIAS_NAME="claude"
CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/$CLAUDE_ALIAS_NAME"
CLAUDE_DATA_DIR="$XDG_DATA_HOME/$CLAUDE_ALIAS_NAME"
CLAUDE_STATE_DIR="$XDG_STATE_HOME/$CLAUDE_ALIAS_NAME"

CLAUDE_DIR_HOME=( "$HOME/.claude" "$CLAUDE_CONFIG_DIR" )
CLAUDE_DIR_LOCAL=( "$CLAUDE_CONFIG_DIR/local" "$CLAUDE_DATA_DIR/local" )
CLAUDE_DIR_PROJECTS=( "$CLAUDE_CONFIG_DIR/projects" "$CLAUDE_STATE_DIR/projects" )
CLAUDE_DIR_TODOS=( "$CLAUDE_CONFIG_DIR/todos" "$CLAUDE_STATE_DIR/todos" )
CLAUDE_DIR_STATSIG=( "$CLAUDE_CONFIG_DIR/statsig" "$CLAUDE_STATE_DIR/statsig" )
CLAUDE_FILE_HOME=("$HOME/.claude.json" "$CLAUDE_CONFIG_DIR/.claude.home.json")

handle_folder "${CLAUDE_DIR_HOME[@]}"
handle_folder "${CLAUDE_DIR_LOCAL[@]}"
handle_folder "${CLAUDE_DIR_PROJECTS[@]}"
handle_folder "${CLAUDE_DIR_TODOS[@]}"
handle_folder "${CLAUDE_DIR_STATSIG[@]}"
handle_file "${CLAUDE_FILE_HOME[@]}"

set +eo pipefail
