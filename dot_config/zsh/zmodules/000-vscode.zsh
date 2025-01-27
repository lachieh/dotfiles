# VSCode

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  export ZDOTDIR="${HOME}/.config/zsh"
  export VSCODE_SUGGEST=1
  . "$(code --locate-shell-integration-path zsh)"
fi
