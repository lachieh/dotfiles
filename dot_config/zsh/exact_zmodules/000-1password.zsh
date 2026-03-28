# shellcheck disable=SC2148

# 1password completion
if [ -z "$PS1" ] || [ -z "$SSH_CLIENT" ]; then
  # if we're in a vscode remote session, or we're non-interactive, or in ssh, don't set up 1password CLI
  return
elif [ -x "$(command -v op)" ]; then
  eval "$(op completion zsh)"; compdef _op op
  if [ -z "${SSH_TTY}" ]; then
    export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  fi
  # 1password CLI plugins. See: https://developer.1password.com/docs/cli/shell-plugins
  if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
    source "${XDG_CONFIG_HOME}/op/plugins.sh"
  fi
fi
