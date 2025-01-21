
# Antidote
ANTIDOTE="$(brew --prefix)/share/antidote"
if [ -d "$ANTIDOTE" ]; then
  source "$ANTIDOTE/antidote.zsh"
  if [ -d "${ZDOTDIR}/.config/zsh" ]; then
    source "${ZDOTDIR}/.config/zsh/.zplugins.zsh"
  else
    source "${HOME}/.zplugins.zsh"
  fi
fi
