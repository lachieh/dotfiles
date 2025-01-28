#!/bin/zsh
# When loaded through the prompt command, these prompt_* options will be enabled
prompt_opts=(cr percent sp subst)

local -a cmds=(
  $commands[starship](N)
  /opt/homebrew/bin/starship(N)
  /usr/local/bin/starship(N)
)
local starship=$cmds[1]

if [[ -n "$1" ]]; then
  local -a configs=(
    $__zsh_config_dir/themes/$1.toml(N)
    ${XDG_CONFIG_HOME:-$HOME/.config}/starship/$1.toml(N)
  )
  (( $#configs )) && export STARSHIP_CONFIG=$configs[1]
fi

# Initialize starship.
if zstyle -t ':zephyr:plugin:prompt' 'use-cache'; then
  cached-eval 'starship-init-zsh' $starship init zsh
else
  source <($starship init zsh)
fi