#!/usr/bin/env zsh
# Personal aliases, loaded in every zsh including agent shells.

alias gfom="git fetch origin main"
alias gfum="git fetch upstream main"
alias gswm="git switch main"
alias nah='_with_msg "git reset --hard HEAD" "yeah, nah. ditch all that"'
alias yolo='_with_msg "git add -A && git commit -m \"$(curl -s https://api.kanye.rest/ | jq '\''.quote'\'')\"" "yolo commiting"'

alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget/wget-hsts"'
alias tmux='tmux -f "$TMUX_CONFIG"'

alias ghcpub="gh repo create --confirm --public"
alias ghcprv="gh repo create --confirm --private"
alias gho="gh repo view -w"
