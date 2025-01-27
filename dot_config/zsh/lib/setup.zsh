# zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

typeset -A ZI
[ ! -d $ZI[HOME_DIR] ] && mkdir -p "$ZI[HOME_DIR]"
ZI[BIN_DIR]="${HOME}/.zi/bin"
[ ! -d $ZI[BIN_DIR] ] && mkdir -p "$ZI[BIN_DIR]"
[ ! -d $ZI[BIN_DIR]/.git ] && git clone https://github.com/z-shell/zi.git "$ZI[BIN_DIR]"
source "${ZI[BIN_DIR]}/zi.zsh"

# compinit initialization
autoload -Uz _zi
(( ${+_comps} )) && _comps[zi]=_zi
