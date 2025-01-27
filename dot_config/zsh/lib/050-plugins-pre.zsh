# Atuin
zinit ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zinit light atuinsh/atuin

# ASDF
zinit snippet OMZP::asdf

# Helper plugins
zinit ice pick"plugins/environment/environment.plugin.zsh" lucid
zinit load mattmc3/zephyr

zinit ice pick"plugins/zfunctions/zfunctions.plugin.zsh." lucid
zinit load mattmc3/zephyr

# Starship
zinit ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zinit light starship/starship
