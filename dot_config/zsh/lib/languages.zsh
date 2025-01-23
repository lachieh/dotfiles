# pyenv config
if [ -x "$(command -v pyenv)" ]; then
  eval "$(pyenv init -)"
fi

# go
if [ -x "$(command -v go)" ]; then
  GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
fi

# rust
[[ -r $HOME/.cargo/env ]] && source "$HOME/.cargo/env"
[ -x "$(command -v rustup)" ] && export PATH="$HOME/.cargo/bin:$PATH"
