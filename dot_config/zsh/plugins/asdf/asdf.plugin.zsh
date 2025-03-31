#!/bin/zsh
# shellcheck disable=SC1071

# References:
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/asdf/asdf.plugin.zsh

export ASDF_DATA_DIR="$XDG_DATA_HOME/asdf"

ASDF_DIR="${ASDF_DIR:-$ASDF_DATA_DIR}"
ASDF_COMPLETIONS="$ASDF_DIR/completions"

if [[ ! -f "$ASDF_DIR/asdf" || ! -f "$ASDF_COMPLETIONS/_asdf" ]]; then
  if (( $+commands[brew] )); then
    _ASDF_PREFIX="$(brew --prefix asdf)"
    ASDF_DIR="${_ASDF_PREFIX}/bin"
    ASDF_COMPLETIONS="${_ASDF_PREFIX}/share/zsh/site-functions"
    PATH=$ASDF_DIR/asdf:$PATH
    unset _ASDF_PREFIX
  else
    return
  fi
fi

# Load asdf
if (( $+commands[asdf] )); then
  # Load completions
  if [[ -f "$ASDF_COMPLETIONS/_asdf" ]]; then
    fpath+=("$ASDF_COMPLETIONS")
    autoload -Uz _asdf
    compdef _asdf asdf # compdef is already loaded before loading plugins
  fi

  # Load Shims
  if [[ -d "$ASDF_DATA_DIR/shims" ]]; then
    PATH=$ASDF_DATA_DIR/shims:$PATH
  fi
fi