# Git Aliases

alias gfom="git fetch origin main"
alias gfum="git fetch upstream main"
alias gswm="git switch main"
alias nah='_with_msg "git reset --hard HEAD" "yeah, nah. ditch all that"'
alias yolo='_with_msg "git add -A && git commit -m \"$(curl -s https://api.kanye.rest/ | jq '\''.quote'\'')\" "yolo commiting"'
