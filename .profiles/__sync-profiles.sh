#!/bin/bash

if [[ $CHEZMOI -ne 1 && $CHEZMOI_OS != "darwin" ]]; then
  exit 0
fi

scriptsPath="$CHEZMOI_SOURCE_DIR/.chezmoiscripts/brew"
profilesPath="$CHEZMOI_SOURCE_DIR/.profiles"

# Sources
profiles=$(find "$profilesPath" -name '*.brewfile')

for file in $profiles; do
  name=$(basename "$file" .brewfile)
  path="$scriptsPath/run_onchange_brew-install-$name.sh.tmpl"
  cat <<EOF > "$path"
{{ if (or (has "$name" $.profiles) (eq "$name" "_default")) -}}
#!/bin/bash

# $name: {{ include "$file" | sha256sum }}

log() { printf "\e[33m%s\e[0m\n" "\$@"; }

log "Installing from $name profile..."
brew bundle --file="$file"
{{- end }}
EOF
  chmod +x "$path"
done
