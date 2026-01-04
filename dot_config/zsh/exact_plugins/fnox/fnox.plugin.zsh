#!/usr/bin/env zsh
# shellcheck disable=SC1090

# References:
# - https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/fnox/fnox.plugin.zsh

# Exit if the 'fnox' command can not be found
if ! (( $+commands[fnox] )); then
    return
fi

# Activate `fnox` within the zsh shell and provide access to any
# globally installed tools within your `.zshrc` file.
source <(fnox activate zsh)

# Completions directory for `fnox` command
local COMPLETIONS_DIR="$XDG_CACHE_HOME/zsh/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `fnox`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_fnox" ]]; then
    typeset -g -A _comps
    autoload -Uz _fnox
    _comps[fnox]=_fnox
fi

# Generate and load completion in the background
fnox completions zsh >| "$COMPLETIONS_DIR/_fnox" &|
