#! /bin/zsh

# Atuin plugin for zsh
ATUIN_DATA_PATH="${ATUIN_DATA_DIR:-$XDG_CONFIG_HOME/atuin}"
ATUIN_CONFIG_DIR="${ATUIN_CONFIG_DIR:-$XDG_CONFIG_HOME/atuin}"

# Load Atuin plugin using antidote
if [[ $+commands[atuin] ]]; then
  # init
  [[ -f "${ATUIN_DATA_PATH}/init.zsh" ]] || atuin init zsh > "${ATUIN_DATA_PATH}/init.zsh"
  source "${ATUIN_DATA_PATH}/init.zsh"
  # completion
  [[ -f "${ATUIN_DATA_PATH}/_atuin" ]] || atuin gen-completions --shell zsh > "${ATUIN_DATA_PATH}/_atuin"
  fpath=("${ATUIN_DATA_PATH}" $fpath)
fi
