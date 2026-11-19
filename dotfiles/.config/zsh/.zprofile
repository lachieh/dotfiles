#!/usr/bin/env zsh
# Managed by mise dotfiles and locked read-only. Edit the source in
# ~/.config/mise/dotfiles/ and run `mise run dotfiles:apply`.
#
# macOS runs /etc/zprofile before this file in login shells, and its
# path_helper rebuilds PATH with the system directories first, behind which
# go mise's tools, ~/.local/bin and the rest of what .zshenv set up. Restore
# the order .zshenv left, keeping anything path_helper added at the end.

if [[ -n $_zshenv_path ]]; then
  typeset -U path
  path=(${(s.:.)_zshenv_path} $path)
  unset _zshenv_path
fi
