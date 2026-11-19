# shellcheck shell=sh
# Environment shared by zsh and bash, for every shell including agent tool
# shells. POSIX sh only: bash sources this too. Tool activation (mise, fnox)
# is shell-specific and lives in each shell's own startup file.

export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_RUNTIME_DIR="${XDG_RUNTIME_DIR:-$HOME/.xdg}"
export XDG_PROJECTS_DIR="$HOME/Projects"

# Keep tools' config and data under the XDG directories instead of ~.
export AWS_CONFIG_FILE="$XDG_CONFIG_HOME/aws/config"
export AWS_SHARED_CREDENTIALS_FILE="$XDG_DATA_HOME/aws/credentials"
export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundle"
export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle"
export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundle"
export DOCKER_CONFIG="$XDG_CONFIG_HOME/docker"
export GEM_HOME="$XDG_DATA_HOME/gem"
export GEM_SPEC_CACHE="$XDG_CACHE_HOME/gem"
export GNUPGHOME="$XDG_DATA_HOME/gnupg"
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export LESSKEY="$XDG_CONFIG_HOME/less/lesskey"
export NODE_REPL_HISTORY="$XDG_DATA_HOME/nodejs/repl_history"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npm/npmrc"
export SCREENRC="$XDG_CONFIG_HOME/screen/screenrc"
export TMUX_CONFIG="$XDG_CONFIG_HOME/tmux/tmux.conf"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

export EDITOR="${EDITOR:-nano}"
export VISUAL="${VISUAL:-nano}"
export PAGER="${PAGER:-less}"
export LESS="-g -i -M -R -S -w -z-4"
if [ "$(uname)" = Darwin ]; then
  export BROWSER="${BROWSER:-open}"
  export SHELL_SESSIONS_DISABLE=1
fi

# Name the agent running this shell, if any, in one variable. Claude Code sets
# AI_AGENT itself, so an existing value wins. Own markers are checked before
# CLAUDECODE so an agent launched from a Claude Code shell reports itself.
if [ -z "${AI_AGENT:-}" ]; then
  if [ -n "${OPENCODE:-}" ]; then
    export AI_AGENT=opencode
  elif [ -n "${CODEX_CI:-}" ]; then
    export AI_AGENT=codex
  elif [ -n "${HERMES_SESSION_ID:-}" ]; then
    export AI_AGENT=hermes
  elif [ -n "${CLAUDECODE:-}" ]; then
    export AI_AGENT=claude
  fi
fi

# Homebrew, only where it is still installed. Tools come from mise.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /home/linuxbrew/.linuxbrew/bin/brew ]; then
  eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
fi

# Move (or add) a directory to the front of PATH.
_prepend_path() {
  _pp_new=$1
  _pp_ifs=$IFS
  IFS=:
  for _pp_dir in $PATH; do
    [ "$_pp_dir" = "$1" ] || _pp_new="$_pp_new:$_pp_dir"
  done
  IFS=$_pp_ifs
  PATH=$_pp_new
  unset _pp_new _pp_ifs _pp_dir
}
_prepend_path "$HOME/go/bin"
_prepend_path "$XDG_DATA_HOME/cargo/bin"
export PNPM_HOME="$XDG_DATA_HOME/pnpm"
_prepend_path "$PNPM_HOME/bin"
_prepend_path "$HOME/.local/bin"
unset -f _prepend_path
export PATH

export _ZO_DATA_DIR="$XDG_DATA_HOME/zoxide"

# SSH agent. Keys live in 1Password on the machine you sit at; everywhere else
# borrows them through agent forwarding, so Touch ID prompts land locally.
#   over SSH  -> the forwarded agent, via the stable link ~/.ssh/rc maintains
#   locally   -> the 1Password agent, when this machine runs 1Password
if [ -n "${SSH_CONNECTION:-}" ] && [ -S "$HOME/.ssh/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.ssh/agent.sock"
elif [ -S "$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"
elif [ -S "$HOME/.1password/agent.sock" ]; then
  export SSH_AUTH_SOCK="$HOME/.1password/agent.sock"
fi
