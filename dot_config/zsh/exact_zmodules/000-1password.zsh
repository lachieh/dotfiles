# 1password completion
if [ -x "$(command -v op)" ]; then
  eval "$(op completion zsh)"; compdef _op op
  # 1Password Agent Symlink on macOS
  if [[ "$(uname)" == "Darwin" ]]; then
  # check if link has not been created and make sure that agent is enabled
  if [ ! -L ~/.1password/agent.sock ] && [ -e "${HOME}/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
    # create symlink to 1password agent
    mkdir -p ~/.1password && ln -s ~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock ~/.1password/agent.sock
  fi
  fi
fi
