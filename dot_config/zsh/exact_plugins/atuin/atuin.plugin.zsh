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
  # auth
  if [[ $(atuin account verify &>/dev/null) -ne 0 ]]; then
    echo "Logging into atuin account from 1Password..."
    OP_VAULT_UUID="c5pj6izhhuuirobusafxvnkqau"
    OP_ITEM_UUID="omx4nfxuac33q6v6g7fnr2pznq"
    OP_PATH="op://$OP_VAULT_UUID/$OP_ITEM_UUID"
    atuin account login \
      --username "$(op read "$OP_PATH/username")" \
      --password "$(op read "$OP_PATH/password")" \
      --key "$(op read "$OP_PATH/key")"
  fi
fi
