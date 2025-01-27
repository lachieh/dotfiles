# Atuin
zi ice as"command" from"gh-r" bpick"atuin-*.tar.gz" mv"atuin*/atuin -> atuin" \
    atclone"./atuin init zsh > init.zsh; ./atuin gen-completions --shell zsh > _atuin" \
    atpull"%atclone" src"init.zsh"
zi light atuinsh/atuin

# ASDF
zi snippet OMZP::asdf

# Helper plugins
zi ice pick"plugins/environment/environment.plugin.zsh" lucid
zi load mattmc3/zephyr

zi ice pick"plugins/zfunctions/zfunctions.plugin.zsh." lucid
zi load mattmc3/zephyr

# Starship
zi ice as"command" from"gh-r" \
  atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" \
  atpull"%atclone" src"init.zsh"
zi light starship/starship
