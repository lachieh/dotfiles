if [ -x "$(command -v ncdu)" ]; then
  alias du="ncdu --color dark -e -rr -x --exclude .git --exclude node_modules"
fi
