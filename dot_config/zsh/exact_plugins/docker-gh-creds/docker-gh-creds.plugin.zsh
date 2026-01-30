#!/usr/bin/env zsh
# shellcheck disable=SC1090

if (( ${+commands[docker]} )); then
  return
fi

if (( ! ${+commands[gh]} )); then
  return
fi

fpath=(${0:A:h} $fpath)
autoload -Uz ${0:A:h}/docker-credential-gh

# Check the docker config.json and see if ghcr.io is already set to use this helper
docker_config_file="${DOCKER_CONFIG:-$HOME/.docker}/config.json"
if [[ -f "$docker_config_file" ]]; then
  config_includes_gh_helper=false
  if jq -e '.credHelpers["ghcr.io"] == "gh"' "$docker_config_file" >/dev/null; then
    config_includes_gh_helper=true
  fi
  
  if ! $config_includes_gh_helper; then
    # use jq to update the config file
    tmp_file="$(mktemp)"
    jq '.credHelpers["ghcr.io"] = "gh" | .credHelpers["docker.pkg.github.com"] = "gh"' "$docker_config_file" > "$tmp_file" && mv "$tmp_file" "$docker_config_file"
    rm -f "$tmp_file"
  fi
fi