#!/usr/bin/env zsh
# shellcheck disable=SC1071

# Source anything in zmodules.
for _rc in ${ZDOTDIR}/zmodules/*.zsh; do
  # Ignore tilde files.
  [[ $_rc:t != '~'* ]] && source "$_rc"
done
unset _rc
