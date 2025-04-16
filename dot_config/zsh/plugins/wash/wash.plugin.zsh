#!/usr/bin/env zsh
# shellcheck disable=SC1090

##### Setup #####

# Exit if the 'wash' command can not be found
if ! (( $+commands[wash] )); then
  return
fi


##### Environment variables #####

WASH_CACHE_DIR="${WASH_CACHE_DIR:-$XDG_CACHE_HOME/wash}"
[[ ! -d $WASH_CACHE_DIR ]] && mkdir -p "$WASH_CACHE_DIR"
WASH_CONFIG_DIR="${WASH_CONFIG_DIR:-$XDG_CONFIG_HOME/wash}"
[[ ! -d $WASH_CONFIG_DIR ]] && mkdir -p "$WASH_CONFIG_DIR"
WASH_DATA_DIR="${WASH_DATA_DIR:-$XDG_DATA_HOME/wash}"
[[ ! -d $WASH_DATA_DIR ]] && mkdir -p "$WASH_DATA_DIR"


##### Completion #####

WASH_COMPLETIONS_DIR="${WASH_CACHE_DIR}/completions"
[[ ! -d $WASH_COMPLETIONS_DIR ]] && mkdir -p "$WASH_COMPLETIONS_DIR"

# If the completion file does not exist yet, then we need to autoload and bind
# it to `wash`. Otherwise, compinit will have already done that.
if [[ ! -f "$WASH_COMPLETIONS_DIR/_wash" ]]; then
    typeset -g -A _comps
    autoload -Uz _wash
    _comps[wash]=_wash
fi

# Generate and load completion in the background
wash completions -d $WASH_COMPLETIONS_DIR zsh &>/dev/null &|
