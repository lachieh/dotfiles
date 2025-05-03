# go
if [ -x "$(command -v go)" ]; then
  GOPATH="$(go env GOPATH)"
  export PATH="$GOPATH/bin:$PATH"
fi
