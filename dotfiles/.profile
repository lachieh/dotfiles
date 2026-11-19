# Managed by mise dotfiles, read-only. Edit ~/.config/mise/dotfiles/.profile
# and run `mise run dotfiles:apply`.
#
# Login sh (dash, or sh on macOS): the same environment as bash and zsh. Tools
# that run commands through `sh -lc`, like T3 Code over SSH, find the mise
# tools and agent CLIs this way. bash reads ~/.bash_profile and zsh reads
# ~/.config/zsh instead.
. "$HOME/.config/shell/env.sh"
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" env -s bash)"
fi
