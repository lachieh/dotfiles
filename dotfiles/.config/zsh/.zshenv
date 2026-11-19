#!/usr/bin/env zsh
# Managed by mise dotfiles and locked read-only. Edit the source in
# ~/.config/mise/dotfiles/ and run `mise run dotfiles:apply`.
#
# Every zsh reads this: terminals, agent tool shells, `zsh -c`. It sets up
# everything an agent needs to use the CLI the way you do: tools, secrets,
# aliases and functions. Human-only extras live in .zshrc.

export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}
emulate sh -c '. "$HOME/.config/shell/env.sh"'

# Script files inherit the environment of whatever ran them.
[[ -n $ZSH_SCRIPT ]] && return

# Tools: mise puts each tool's real directory on PATH for the current
# directory and updates it on cd. No shims.
if (( $+commands[mise] )); then
  eval "$(mise activate zsh)"
fi

# Secrets: fnox loads a project's fnox.toml values on cd.
if (( $+commands[fnox] )); then
  eval "$(fnox activate zsh)"
fi

# Remember PATH for .zprofile, which restores it after macOS path_helper.
[[ -o login ]] && typeset -g _zshenv_path=$PATH

# Aliases and functions. Functions are autoloaded, and agent shells that
# snapshot their state need the real bodies, so force-load them with +X.
fpath=($ZDOTDIR/functions $fpath)
autoload -Uz +X $ZDOTDIR/functions/*(N.:t)
source $ZDOTDIR/vendor/omz-git.zsh
source $ZDOTDIR/aliases.zsh

# Non-interactive shells (agent tools) send commands written for bash. Parse
# them like bash. Interactive shells set these at the end of .zshrc instead,
# after plugins that expect zsh defaults have loaded.
typeset -ga bash_compat_options=(
  no_nomatch
  no_bad_pattern
  no_equals
  sh_word_split
  glob_subst
  no_extended_glob
  no_bare_glob_qual
)
[[ -o interactive ]] || setopt $bash_compat_options
