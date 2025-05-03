#!/bin/bash
# shellcheck disable=SC1090

set -eufo pipefail

echo ""
echo "Hi! 🤚 Lachie's dotfiles Installer."
read -n 1 -r -s -p $'    Press any key to continue or Ctrl+C to abort...\n\n'

# Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo '🍺  Installing Homebrew'
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install chezmoi
if ! command -v chezmoi >/dev/null 2>&1; then
  echo '🤖  Installing chezmoi'
  brew install chezmoi
fi

# Install mise
if ! command -v mise >/dev/null 2>&1; then
  echo '🧩  Installing mise'
  brew install mise

  source <(/opt/homebrew/bin/mise activate zsh)
  source <(/opt/homebrew/bin/mise hook-env -s zsh)
fi

if [ -d "$HOME/.local/share/chezmoi/.git" ]; then
  echo "🚸  chezmoi already initialized"
  echo "    Reinitialize with: 'chezmoi init https://github.com/lachieh/dotfiles.git'"
else
  eval "$(/opt/homebrew/bin/brew shellenv)"
  (echo '🚀  Downloading dotfiles with:' && chezmoi init https://github.com/lachieh/dotfiles.git)
fi

echo ""
echo "Done."