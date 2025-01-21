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
if [ -x "$(command -v rustup)" ]; then
  export PATH="$HOME/.cargo/bin:$PATH"
  source "$HOME/.cargo/env"
fi