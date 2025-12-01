#!/usr/bin/env zsh
# shellcheck disable=SC1090

if (( ${+commands[killport]} )); then
  return
fi

autoload -Uz killport

if (( ${+_comps[killport]} )); then
  typeset -g -A _comps
  autoload -Uz _killport
  _comps[killport]=_killport
fi