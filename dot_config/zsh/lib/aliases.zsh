if [ -x "$(command -v ncdu)" ]; then
  alias du="ncdu --color dark -e -rr -x --exclude .git --exclude node_modules"
fi

if [ -x "$(command -v gh)" ]; then
  alias ghcpub="gh create --confirm --public"
  alias ghcprv="gh create --confirm --private"
  alias gho="gh repo view -w"
fi

if [ -x "$(command -v eza)" ]; then
  alias ls="eza"
  alias ll="eza -al"
fi

alias chez="chezmoi"

# git aliases
alias gfom="git fetch origin main"
alias gfum="git fetch upstream main"
alias gswm="git switch main"
alias nah='_with_msg "git reset --hard HEAD" "yeah, nah. ditch all that"'
alias yolo='_with_msg "git add -A && git commit -m \"$(curl -s https://api.kanye.rest/ | jq '\''.quote'\'')\" "yolo commiting"'
