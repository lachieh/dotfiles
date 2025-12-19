#!/usr/bin/env zsh

# sorry, mum

$UGH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/ugh"
$OG_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/thefuck"

# if the folder config dir does not exist, create it
if [[ ! -d "${UGH_CONFIG_DIR}" ]]; then
  mkdir -p "${UGH_CONFIG_DIR}"
fi

# if the og config dir exists, is not a symlink
if [[ -d "${OG_CONFIG_DIR}" ]]; then
  if [[ ! -L "${OG_CONFIG_DIR}" ]]; then
    # move its contents to the new ugh config dir, delete it, and symlink it to the ugh config dir
    mv "${OG_CONFIG_DIR}/*" "${UGH_CONFIG_DIR}"
    rmdir "${OG_CONFIG_DIR}"
    ln -s "${UGH_CONFIG_DIR}" "${OG_CONFIG_DIR}"
  fi
fi

eval "$(thefuck --alias ugh)"