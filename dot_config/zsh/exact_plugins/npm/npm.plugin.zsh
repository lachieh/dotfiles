#!/usr/bin/env zsh
# shellcheck disable=SC1090

if [[ ! (( ${+commands[npm]} )) ]]; then
  return
fi

# Completions directory for `zsh`
local COMPLETIONS_DIR="$XDG_CACHE_HOME/zsh/completions"

# Add completions to the FPATH
typeset -TUx FPATH fpath
fpath=("$COMPLETIONS_DIR" $fpath)

# If the completion file does not exist yet, then we need to autoload
# and bind it to `npm`. Otherwise, compinit will have already done that.
if [[ ! -f "$COMPLETIONS_DIR/_npm" ]]; then
    typeset -g -A _comps
    autoload -Uz _npm
    _comps[npm]=_npm
fi

cat >| "$COMPLETIONS_DIR/_npm" << 'EOF'
#compdef npm
_npm() {
  local si=$IFS
  compadd -- $(COMP_CWORD=$((CURRENT-1)) \
                COMP_LINE=$BUFFER \
                COMP_POINT=0 \
                npm completion -- "${words[@]}" \
                2>/dev/null)
  IFS=$si
}
compdef _npm npm
EOF
