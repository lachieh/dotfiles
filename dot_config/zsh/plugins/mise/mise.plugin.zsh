#!/usr/bin/env zsh
# shellcheck disable=SC1090

# References:
# - https://github.com/wintermi/zsh-mise/blob/main/zsh-mise.plugin.zsh
# - https://mise.jdx.dev/mise-cookbook/shell-tricks.html#prompt-colouring

# Exit if the 'mise' command can not be found
if ! (( $+commands[mise] )); then
    return
fi

# Activate `mise` within the zsh shell and provide access to any
# globally installed tools within your `.zshrc` file.
# https://mise.jdx.dev/dev-tools/shims.html#zshrc-bashrc-files
source <(mise activate zsh)
source <(mise hook-env -s zsh)

# Completions directory for `mise` command
local COMPLETIONS_DIR="${0:A:h}/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `mise`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_mise" ]]; then
    typeset -g -A _comps
    autoload -Uz _mise
    _comps[mise]=_mise
fi

# Generate and load completion in the background
mise completions zsh >| "$COMPLETIONS_DIR/_mise" &|

# set up the completion function
typeset -i _mise_updated

# replace default mise hook
function _mise_hook {
  local diff=${__MISE_DIFF}
  source <(mise hook-env -s zsh)
  [[ ${diff} == ${__MISE_DIFF} ]]
  _mise_updated=$?
}

_PROMPT="${PROMPT:-❱ }"
function _prompt {
  if (( ${_mise_updated} )); then
    PROMPT='%F{blue}${_PROMPT}%f'
  else
    PROMPT='%(?.%F{green}${_PROMPT}%f.%F{red}${_PROMPT}%f)'
  fi
}

add-zsh-hook precmd _prompt