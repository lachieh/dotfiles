#!/usr/bin/env zsh
# shellcheck disable=SC1071

# Config for agent tool shells (Claude Code and friends), loaded from
# .zprofile. Not part of the numbered .zshrc sequence — it is a second, much
# smaller entry point into the same files, so nothing here is a copy of
# .zshrc. Add a personal alias to zmodules/ and both shells get it.
#
# Deliberately skipped:
#   200-plugins  the antidote bundle. It is the whole cost (0.28s vs 0.03s)
#                and every function it defines lands in the agent's shell
#                snapshot, which is then sourced on every single command.
#   700-prompt   an agent shell never draws a prompt.
#   900-post     background post-load work, pointless for a one-shot shell.
#
# mise needs nothing here: PATH is inherited from the terminal that launched
# the agent, so every mise-managed tool already resolves.

source ${ZDOTDIR:-$HOME}/lib/100-setup.zsh
source ${ZDOTDIR:-$HOME}/lib/500-modules.zsh

# gst, gco, gd and the rest live in ohmyzsh's git plugin, not zmodules. Worth
# the one exception to the no-plugins rule: they are the aliases anyone
# actually reaches for, and they measure free. Sourced by path rather than
# through antidote, so none of the rest of the bundle rides along.
_agent_git_plugin=${ANTIDOTE_HOME:-${XDG_CACHE_HOME:-$HOME/.cache}/repos}/ohmyzsh/ohmyzsh/plugins/git/git.plugin.zsh
if [[ -r $_agent_git_plugin ]]; then
  # The plugin registers completions, but compinit never runs in a shell with
  # no prompt. Stub compdef for the duration instead of eating an error per
  # registration, then put things back.
  if (( ! $+functions[compdef] )); then
    compdef() { : }
    _agent_stubbed_compdef=1
  fi
  source $_agent_git_plugin
  (( $+_agent_stubbed_compdef )) && unfunction compdef
fi
unset _agent_git_plugin _agent_stubbed_compdef

# Agent shells capture this state into a snapshot file and replay it for each
# command, but the snapshot keeps PATH and not fpath. A lazy autoload stub
# would serialise as "# undefined" and break, so force the real bodies in with
# +X. Cheap: these are a handful of small files.
autoload -Uz +X ${ZDOTDIR:-$HOME}/functions/*(N.:t)
