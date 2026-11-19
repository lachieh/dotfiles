# shellcheck shell=bash
# Managed by mise dotfiles and locked read-only. Edit the source in
# ~/.config/mise/dotfiles/ and run `mise run dotfiles:apply`.
#
# For agents and tools that run bash. Same environment as zsh: shared env,
# mise tools and fnox secrets. zsh is the interactive shell, so nothing else.

. "$HOME/.config/shell/env.sh"

if command -v mise >/dev/null 2>&1; then
  eval "$(mise activate bash)"
fi
if command -v fnox >/dev/null 2>&1; then
  eval "$(fnox activate bash)"
fi
