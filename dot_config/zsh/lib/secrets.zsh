# export secret env variables from ~/.secrets
set -o allexport
if [ -f ~/.secrets ]; then source "${HOME}/.secrets"; fi
set +o allexport