
# Antidote
ANTIDOTE="$(brew --prefix)/share/antidote"
if [ -d "$ANTIDOTE" ]; then
  source "$ANTIDOTE/antidote.zsh"
  local SRC="${ZDOTDIR:-$HOME}/.zplugins"
  local DST="${ZDOTDIR:-$HOME}/.zplugins.zsh"
  if [ ! -f $DST ]; then antidote bundle < $SRC > $DST; fi
  source $DST
fi
