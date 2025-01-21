
# Antidote
ANTIDOTE="$(brew --prefix)/share/antidote"
if [ -d "$ANTIDOTE" ]; then
  source "$ANTIDOTE/antidote.zsh"
  # - load plugins
  source "${HOME}/.zplugins.sh"
  # - run zupdate when changing .zplugins
  alias zupdate="antidote bundle < ~/.zplugins > ~/.zplugins.sh"
fi
