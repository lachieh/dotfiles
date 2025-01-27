
# Antidote
export ZSH_CUSTOM=${ZSH_CUSTOM:-$ZDOTDIR}
export ANTIDOTE_HOME=${ANTIDOTE_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/repos}
zstyle ':antidote:bundle' use-friendly-names 'yes'
zstyle ':antidote:bundle' file ${ZDOTDIR:-~}/.zplugins
zstyle -s ':antidote:repo' path antidote_path \
  || antidote_path=$ANTIDOTE_HOME/mattmc3/antidote

# Clone antidote if missing.
[[ -d $antidote_path ]] \
  || git clone --depth 1 --quiet https://github.com/mattmc3/antidote $antidote_path

# Lazy-load antidote from its functions directory.
fpath=($antidote_path/functions $fpath)
autoload -Uz antidote

# asdf + direnv
export ASDF_NODEJS_AUTO_ENABLE_COREPACK=true
export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf
[[ $+commands[asdf] ]] && source /opt/homebrew/opt/asdf/libexec/asdf.sh
[[ $+commands[direnv] ]] && eval "$(asdf exec direnv hook zsh)"

# Generate static file in a subshell whenever .zplugins is updated.
zplugins=${ZDOTDIR:-~}/.zplugins
if [[ ! ${zplugins}.zsh -nt ${zplugins} ]] || [[ ! -e $ANTIDOTE_HOME/.lastupdated ]]; then
  antidote bundle <${zplugins} >|${zplugins}.zsh
  date +%Y-%m-%dT%H:%M:%S%z >| $ANTIDOTE_HOME/.lastupdated
fi

# Lazy-load (autoload) Zsh function files from a directory.
ZFUNCDIR=${ZDOTDIR}/zfunctions
fpath=($ZFUNCDIR $fpath)
autoload -Uz $ZFUNCDIR/*(.:t)

# Source the static file.
source ${zplugins}.zsh