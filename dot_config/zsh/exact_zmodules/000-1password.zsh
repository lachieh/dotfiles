# 1password completion
if [ -x "$(command -v op)" ]; then
  eval "$(op completion zsh)"; compdef _op op
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
  # 1password CLI plugins. See: https://developer.1password.com/docs/cli/shell-plugins
  if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
    source "${XDG_CONFIG_HOME}/op/plugins.sh"
  fi
fi
