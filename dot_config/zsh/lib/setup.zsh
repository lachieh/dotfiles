
# Antidote
ANTIDOTE="$(brew --prefix)/share/antidote"
if [ -d "$ANTIDOTE" ]; then
  source "$ANTIDOTE/antidote.zsh"
  source "${ZDOTDIR/.config/zsh/.zplugins.zsh:-$HOME/.zplugins.zsh}"
fi
