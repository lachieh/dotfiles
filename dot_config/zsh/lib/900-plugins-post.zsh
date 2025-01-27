# Oh My Zsh plugins
zinit is-snippet wait lucid for \
    atload"unalias grv g" \
  OMZP::{git,sudo,encode64,extract,command-not-found}

# homebrew/brew
zinit wait pack atload=+"zicompinit_fast; zicdreplay" for brew-completions

# jq
# zinit wait lucid for if"(( ! ${+commands[jq]} ))" as"null" \
#   atclone"autoreconf -fi && ./configure --with-oniguruma=builtin && make \
#   && ln -sfv $PWD/jq.1 $ZI[MAN_DIR]/man1" sbin"jq" \
#     stedolan/jq

# tealdeer / tldr
# zinit wait lucid as'program' from'gh-r' for \
#   mv'tealdeer* -> tealdeer' \
#   sbin'**/tealdeer -> tldr' \
#   pick'$ZPFX/bin/tldr' \
#   @tealdeer-rs/tealdeer
# zinit ice lucid wait as'completion' blockf has'tldr' mv'zsh_tealdeer -> _tldr'
# zinit snippet https://github.com/tealdeer-rs/tealdeer/blob/main/completion/zsh_tealdeer

# shellcheck
# zinit wait lucid as'program' from'gh-r' for \
#   mv'shellcheck* -> shellcheck' \
#   sbin'**/shellcheck -> shellcheck' \
#   @koalaman/shellcheck

# # fzf, fd, bat, exa
# zinit from"gh-r" as"null" for \
#   sbin"fzf" junegunn/fzf \
#   sbin"**/fd" @sharkdp/fd \
#   sbin"**/bat" @sharkdp/bat \
#   sbin"**/exa -> exa" atclone"cp -vf completions/exa.zsh _exa" ogham/exa

# yt-dlp
zinit for as'program' nocompile'!' depth'1' \
  has'python' pick'$ZPFX/bin/youtube-dl*' make'!PREFIX=$ZPFX install' \
  atclone'ln -sfv youtube-dl.zsh _youtube-dl' atpull'%atclone' \
    ytdl-org/youtube-dl

# kubectx
# zinit wait lucid for as"command" from"gh-r" \
#   bpick"kubectx;kubens" sbin"kubectx;kubens" \
#     ahmetb/kubectx

# zoxide
zinit ice as'null' from"gh-r" sbin
zinit light ajeetdsouza/zoxide
zinit has'zoxide' light-mode for \
  z-shell/zsh-zoxide

# zsh-users/zsh-completions
zinit ice lucid wait as'completion'
zinit light zsh-users/zsh-completions

# zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# g-plane/zsh-yarn-autocompletions
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/zsh-yarn-autocompletions

# g-plane/pnpm-shell-completion
zinit ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zinit light g-plane/pnpm-shell-completion
