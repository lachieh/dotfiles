#!/usr/bin/env zsh
# Managed by mise dotfiles and locked read-only. Edit the source in
# ~/.config/mise/dotfiles/ and run `mise run dotfiles:apply`.
#
# Interactive shells only, after .zshenv has set up tools, secrets, aliases
# and functions. Everything here is for a person at a prompt.

[[ "$ZPROFRC" -ne 1 ]] || zmodload zsh/zprof
alias zprofrc="ZPROFRC=1 zsh"

# Options
setopt auto_cd auto_pushd pushd_ignore_dups pushd_silent
setopt interactive_comments no_beep
setopt extended_history hist_expire_dups_first hist_ignore_dups \
  hist_ignore_space hist_verify share_history
HISTFILE=$XDG_STATE_HOME/zsh/history
HISTSIZE=50000
SAVEHIST=50000
[[ -d ${HISTFILE:h} ]] || mkdir -p ${HISTFILE:h}

KEYTIMEOUT=40

# Listing and colour, for reading at a prompt. Agents get plain ls and grep.
export CLICOLOR=1
export LSCOLORS=exfxcxdxbxGxDxabagacad
alias grep='grep --color=auto'
alias diff='diff --color'
if (( $+commands[eza] )); then
  alias ls=eza ll='eza -l' la='eza -la' lsd='eza -d' lsdl='eza -dl' \
    ldot='eza -ld .*' lD='eza -lD' lDD='eza -lDa' lS='eza -l -ssize' lT='eza -l -snewest'
fi
alias hist='fc -li'
alias dirh='dirs -v'
for _i in {1..9}; do alias "$_i"="cd -$_i"; done
unset _i

# Keys: emacs bindings, with word motion on alt/ctrl arrows.
bindkey -e
bindkey '^[[1;3D' backward-word '^[[1;3C' forward-word
bindkey '^[[1;5D' backward-word '^[[1;5C' forward-word

# Completion, with a dump cached for a day.
fpath=($XDG_CACHE_HOME/zsh/completions $fpath)
[[ -d $XDG_CACHE_HOME/zsh/completions ]] || mkdir -p $XDG_CACHE_HOME/zsh/completions
autoload -Uz compinit
() {
  local dump=$XDG_CACHE_HOME/zsh/zcompdump
  local -a stale=(${~dump}(N.mh+24))
  if (( $#stale )) || [[ ! -e $dump ]]; then
    compinit -d $dump
  else
    compinit -C -d $dump
  fi
}
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|=*' 'l:|=*'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Completions for CLIs that generate their own, written once in the background
# when missing (delete the file to refresh). Picked up by the next shell.
() {
  local dir=$XDG_CACHE_HOME/zsh/completions name cmd
  local -A gen=(
    mise  'mise completions zsh'
    fnox  'fnox completions zsh'
    atuin 'atuin gen-completions --shell zsh'
  )
  for name cmd in ${(kv)gen}; do
    (( $+commands[$name] )) && [[ ! -s $dir/_$name ]] || continue
    { eval $cmd >| $dir/_$name.tmp 2>/dev/null && mv $dir/_$name.tmp $dir/_$name } &|
  done
}
if [[ -f ${XDG_CONFIG_HOME}/op/plugins.sh ]]; then
  source ${XDG_CONFIG_HOME}/op/plugins.sh
fi

# VS Code terminal integration.
if [[ $TERM_PROGRAM == vscode ]] && (( $+commands[code] )); then
  source "$(code --locate-shell-integration-path zsh)"
fi

# fzf
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline'
# Key bindings need line editing, which `zsh -ic` without a terminal lacks.
(( $+commands[fzf] )) && [[ -t 0 ]] && source <(fzf --zsh)

# zoxide
(( $+commands[zoxide] )) && eval "$(zoxide init zsh)"

# Shell history search. Only for a person: agent-run commands are captured
# separately by `atuin threads`, so agents never load this hook.
if [[ -z $AI_AGENT ]] && (( $+commands[atuin] )); then
  eval "$(atuin init zsh --disable-up-arrow)"
fi

# Prompt
(( $+commands[starship] )) && eval "$(starship init zsh)"

# Syntax highlighting, cloned by `mise bootstrap` (see [bootstrap.repos]).
_zsh_hl=$XDG_DATA_HOME/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ -r $_zsh_hl ]] && source $_zsh_hl
unset _zsh_hl

[[ "$ZPROFRC" -eq 1 ]] && zprof
unset ZPROFRC

setopt $bash_compat_options
