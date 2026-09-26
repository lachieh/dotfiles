# shellcheck disable=SC2148

# Non-interactive shells inherit their environment; nothing to do.
if [ -z "$PS1" ]; then
  return
fi

if [ -x "$(command -v op)" ]; then
  eval "$(op completion zsh)"; compdef _op op
  # 1password CLI plugins. See: https://developer.1password.com/docs/cli/shell-plugins
  if [ -f "${XDG_CONFIG_HOME}/op/plugins.sh" ]; then
    source "${XDG_CONFIG_HOME}/op/plugins.sh"
  fi
fi

# SSH agent selection:
#   over SSH  -> the agent forwarded from the client (stable symlink kept by ~/.ssh/rc)
#   otherwise -> the local 1Password agent
# Fall back to the local 1Password agent when nothing was forwarded (or the link is stale).
if [ -n "$SSH_CONNECTION" ] && [ -S "$HOME/.ssh/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
else
  export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
fi
