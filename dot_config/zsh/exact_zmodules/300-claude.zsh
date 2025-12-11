#!/usr/bin/env zsh
set -eo pipefail

# Enable debug logging by setting CLAUDE_PLUGIN_DEBUG=true
CLAUDE_PLUGIN_DEBUG=${CLAUDE_PLUGIN_DEBUG:-false}

# This is where we want claude to store its config and data
CLAUDE_CONFIG_DIR="$XDG_CONFIG_HOME/claude-code"
CLAUDE_DATA_DIR="$XDG_DATA_HOME/claude-code"
CLAUDE_STATE_DIR="$XDG_STATE_HOME/claude-code"

log() {
  if [ "$CLAUDE_PLUGIN_DEBUG" = "true" ]; then
    printf "300-claude.zsh \e[33m[LOG]\e[0m %s\n" "$@";
  else
    log() { :; }
  fi
}
err() { printf "300-claude.zsh \e[31m[ERR]\e[0m %s\n" "$@"; }
file_exists() { [ -e "$1" ]; }
folder_exists() { [ -d "$1" ]; }
file_is_symlink() { [ -L "$1" ]; }
symlink_is_target() { [ "$(readlink "$1")" = "$2" ]; }

# Cannot continue if claude is not installed
if [[ ! ${+commands[claude]} ]]; then
  CLAUDE_PLUGIN_DEBUG=true
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
    cp "$src_file$backup_suffix" "$dest_file"
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

  if folder_exists "$src_folder" && ! file_is_symlink "$src_folder" && ; then
    if [ "$(ls -A "$src_folder")" ]; then
      log "Moving contents from $src_folder to $dest_folder"
      cp -R "$src_folder"/* "$dest_folder" 2>/dev/null || true
    fi
    rm -rf "$src_folder"
  fi

  if ! file_is_symlink "$src_folder"; then
    log "Creating symlink: $src_folder -> $dest_folder"
    ln -s "$dest_folder" "$src_folder"
  elif ! symlink_is_target "$src_folder" "$dest_folder"; then
    log "Updating symlink: $src_folder -> $dest_folder"
    rm "$src_folder"
    ln -s "$dest_folder" "$src_folder"
  fi
}

# first, move and link $XDG_CONFIG_HOME/claude to $CLAUDE_CONFIG_DIR
# - claude expects to use this folder, but not for everything
handle_folder $XDG_CONFIG_HOME/claude "$CLAUDE_CONFIG_DIR"

# next, move and link $HOME/.claude to $CLAUDE_CONFIG_DIR
handle_folder "$HOME/.claude" "$CLAUDE_CONFIG_DIR"
handle_folder "$HOME/.claude_worktrees" "$CLAUDE_DATA_DIR/worktrees"

# now handle the various subdirectories and files used by claude into their correct XDG locations
handle_folder "$CLAUDE_CONFIG_DIR/local" "$CLAUDE_DATA_DIR/local"
handle_folder "$CLAUDE_CONFIG_DIR/projects" "$CLAUDE_STATE_DIR/projects"
handle_folder "$CLAUDE_CONFIG_DIR/todos" "$CLAUDE_STATE_DIR/todos"
handle_folder "$CLAUDE_CONFIG_DIR/statsig" "$CLAUDE_STATE_DIR/statsig"

# Finally, move and link the home config file
handle_file "$HOME/.claude.json" "$CLAUDE_CONFIG_DIR/.claude-code.home.json"

set +eo pipefail
