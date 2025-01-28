#!/usr/bin/env zsh
# shellcheck disable=SC1071

# Prompt
setopt prompt_subst transient_rprompt
autoload -Uz promptinit && promptinit
prompt "$ZSH_THEME[@]"

# remove hook from getantidote/use-omz
add-zsh-hook -d precmd set-omz-theme-during-precmd