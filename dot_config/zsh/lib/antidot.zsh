export XDG_RUNTIME_DIR="/run/user/$UID"

export ASDF_DATA_DIR="$XDG_DATA_HOME"/asdf

export LESSHISTFILE="$XDG_STATE_HOME"/less/history

export GNUPGHOME="$XDG_DATA_HOME"/gnupg

export DOCKER_CONFIG="$XDG_CONFIG_HOME"/docker

alias wget=wget --hsts-file="$XDG_DATA_HOME/wget/hsts"

export AWS_SHARED_CREDENTIALS_FILE="$XDG_CONFIG_HOME"/aws/credentials
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME"/aws/config