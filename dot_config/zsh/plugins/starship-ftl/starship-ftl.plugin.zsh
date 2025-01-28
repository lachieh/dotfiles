#!/bin/zsh
# shellcheck disable=SC1071

# References:
# - https://github.com/mattmc3/zdotdir/tree/main/plugins/starship-ftl

# Starship faster-than-light
# Load plugin functions.
0=${(%):-%N}
fpath=(${0:A:h}/functions $fpath)
autoload -Uz ${0:A:h}/functions/*(.:t)
