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
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export RUSTUP_HOME"$XDG_DATA_HOME"/rustup
[[ -r $CARGO_HOME/env ]] && source "$CARGO_HOME/env"
[ -x "$(command -v rustup)" ] && export PATH="$CARGO_HOME/bin:$PATH"
