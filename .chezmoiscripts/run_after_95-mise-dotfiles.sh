#!/bin/bash
# Link mise-managed dotfiles after chezmoi has written mise's own config.

set -euo pipefail

export PATH="$HOME/.local/bin:/opt/homebrew/bin:$PATH"

cd "$HOME"
mise bootstrap dotfiles apply --yes
