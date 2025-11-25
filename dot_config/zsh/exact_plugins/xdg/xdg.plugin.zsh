#!/usr/bin/env zsh
# shellcheck disable=SC1071

# References:
# - https://github.com/mattmc3/zdotdir/tree/main/plugins/xdg/xdg.plugin.zsh

#
# xdg - don't pollute home
#

# XDG basedirs
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share
export XDG_STATE_HOME=~/.local/state
export XDG_RUNTIME_DIR=~/.xdg
export XDG_PROJECTS_DIR=~/Projects

for _xdgdir in XDG_{CONFIG,CACHE,DATA,STATE}_HOME XDG_RUNTIME_DIR; do
  [[ -e ${(P)_xdgdir} ]] || mkdir -p ${(P)_xdgdir}
done
unset _xdgdir

#
# Shell utils
#

# less
export LESSKEY="${LESSKEY:-$XDG_CONFIG_HOME/less/lesskey}"
export LESSHISTFILE="${LESSHISTFILE:-$XDG_CACHE_HOME/less/history}"

# readline
export INPUTRC="${INPUTRC:-$XDG_CONFIG_HOME/readline/inputrc}"

# screen
export SCREENRC="${SCREENRC:-$XDG_CONFIG_HOME/screen/screenrc}"

# tmux
export TMUX_CONFIG="${TMUX_CONFIG:-$XDG_CONFIG_HOME/tmux/tmux.conf}"
alias tmux="${aliases[tmux]:-tmux} -f \"\$TMUX_CONFIG\""

# wget
export WGETRC="${WGETRC:-$XDG_CONFIG_HOME/wget/wgetrc}"
alias wget="${aliases[wget]:-wget} --hsts-file=\$XDG_CACHE_HOME/wget/wget-hsts"

# gnupg
export GNUPGHOME="${GNUPGHOME:-$XDG_DATA_HOME/gnupg}"
[[ -d "$GNUPGHOME" ]] || mkdir -p "$GNUPGHOME"
[[ "$(stat -f '%Lp' "$GNUPGHOME")" != "700" ]] && chmod 700 "$GNUPGHOME"

#
# Dev tools
#

# aws
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config
export AWS_SHARED_CREDENTIALS_FILE="$XDG_DATA_HOME"/aws/credentials

# docker
export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

# kubectl
# kubernetes sig-cli decided to not follow XDG spec by default so we're just
# going to symlink it ourselves
# https://github.com/kubernetes/kubernetes/pull/97885
if [[ -d ~/.kube && ! -L ~/.kube ]]; then
  ln -sf "$XDG_CONFIG_HOME/kube" ~/.kube 2>/dev/null
fi

# node
path+=(
  /{opt/homebrew,usr/local}/share/npm/bin(N)
)
export NPM_CONFIG_USERCONFIG="${NPM_CONFIG_USERCONFIG:-$XDG_CONFIG_HOME/npm/npmrc}"
export NODE_REPL_HISTORY="${NODE_REPL_HISTORY:-$XDG_DATA_HOME/nodejs/repl_history}"

# ruby bundler
export BUNDLE_USER_CONFIG="${BUNDLE_USER_CONFIG:-$XDG_CONFIG_HOME/bundle}"
export BUNDLE_USER_CACHE="${BUNDLE_USER_CACHE:-$XDG_CACHE_HOME/bundle}"
export BUNDLE_USER_PLUGIN="${BUNDLE_USER_PLUGIN:-$XDG_DATA_HOME/bundle}"

# ruby gems
export GEM_HOME="${GEM_HOME:-$XDG_DATA_HOME/gem}"
export GEM_SPEC_CACHE="${GEM_SPEC_CACHE:-$XDG_CACHE_HOME/gem}"

# rust
export CARGO_HOME="${CARGO_HOME:-$XDG_DATA_HOME/cargo}"
export RUSTUP_HOME="${RUSTUP_HOME:-$XDG_DATA_HOME/rustup}"