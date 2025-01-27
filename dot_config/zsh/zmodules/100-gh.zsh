# GitHub CLI
if [ -x "$(command -v gh)" ]; then
  alias ghcpub="gh create --confirm --public"
  alias ghcprv="gh create --confirm --private"
  alias gho="gh repo view -w"
fi
