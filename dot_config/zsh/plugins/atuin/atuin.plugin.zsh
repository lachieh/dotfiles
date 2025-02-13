#! /bin/zsh

ATUIN_DATA_PATH="${ATUIN_DATA_DIR:-$XDG_DATA_HOME/atuin-zsh}"
ATUIN_CONFIG_DIR="${ATUIN_CONFIG_DIR:-$XDG_CONFIG_HOME/atuin}"

# Check if atuin is installed
if [[ $+commands[atuin] ]]; then
  # create data dirs
  mkdir -p "${ATUIN_DATA_PATH}"
  mkdir -p "${ATUIN_DATA_PATH}/compdef"
  # init
  [[ -f "${ATUIN_DATA_PATH}/init.zsh" ]] || atuin init zsh --disable-up-arrow > "${ATUIN_DATA_PATH}/init.zsh"
  source "${ATUIN_DATA_PATH}/init.zsh"
  # completion
  [[ -f "${ATUIN_DATA_PATH}/compdef/_atuin" ]] || atuin gen-completions --shell zsh > "${ATUIN_DATA_PATH}/compdef/_atuin"
  fpath=("${ATUIN_DATA_PATH}/compdef" $fpath)
fi
