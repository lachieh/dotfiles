# zi
typeset -A ZI
ZI[HOME_DIR]="${HOME}/.zi"
ZI[BIN_DIR]="${HOME}/.zi/bin"
if [ ! -d $ZI[HOME_DIR] ]; then
  mkdir -p "$ZI[HOME_DIR]"
  compaudit | xargs chown -R "$(whoami)" "$ZI[HOME_DIR]"
  compaudit | xargs chmod -R go-w "$ZI[HOME_DIR]"
  if [ ! -d $ZI[BIN_DIR] ]; then
    mkdir -p "$ZI[BIN_DIR]"
    git clone https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"
  fi
fi
source "${ZI[BIN_DIR]}/zi.zsh"
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi

# compinit initialization
autoload -Uz compinit
compinit