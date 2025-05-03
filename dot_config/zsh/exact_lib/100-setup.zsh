#!/usr/bin/env zsh
# shellcheck disable=SC1071

# Profiling
[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# XDG environment variables
# Only need some basic ones here, more are set up in `$ZDOTDIR/plugins/xdg`
export XDG_CONFIG_HOME=~/.config
export XDG_CACHE_HOME=~/.cache
export XDG_DATA_HOME=~/.local/share

# Load .zstyles
[[ -r ${ZDOTDIR:-$HOME}/.zstyles ]] && source ${ZDOTDIR:-$HOME}/.zstyles

# Set prompt theme
typeset -ga ZSH_THEME
zstyle -a ':zephyr:plugin:prompt' theme ZSH_THEME || ZSH_THEME=(p10k mmc)

# Set helpers for antidote.
is-theme-p10k()     { [[ "$ZSH_THEME" == (p10k|powerlevel10k)* ]] }
is-theme-starship() { [[ "$ZSH_THEME" == starship* ]] }

# Aliases
[[ -r ${ZDOTDIR:-$HOME}/.zaliases ]] && source ${ZDOTDIR:-$HOME}/.zaliases
