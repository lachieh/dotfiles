# Managed by mise dotfiles and locked read-only. Edit the source in
# ~/.config/mise/dotfiles/ and run `mise run dotfiles:apply`.
#
# zsh reads this file from $HOME before it knows about ZDOTDIR, so it only
# points zsh at the real config. Installers that append to ~/.zshrc or
# ~/.zprofile write to files zsh never reads.

export ZDOTDIR="$HOME/.config/zsh"
. "$ZDOTDIR/.zshenv"
