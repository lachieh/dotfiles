#!/usr/bin/env zsh
# shellcheck disable=SC1090

##### Setup #####

# Exit if the 'wash' command can not be found
if ! (( $+commands[wash] )); then
  return
fi


##### Environment variables #####

##### Completion #####
source <(pnpm completion zsh)