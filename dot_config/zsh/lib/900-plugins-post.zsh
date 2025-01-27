# Oh My Zsh plugins
zi is-snippet wait lucid for \
    atload"unalias grv g" \
  OMZP::{git,sudo,encode64,extract,command-not-found}

# homebrew/brew
zi wait pack atload=+"zicompinit_fast; zicdreplay" for brew-completions

# jq
# zi wait lucid for if"(( ! ${+commands[jq]} ))" as"null" \
#   atclone"autoreconf -fi && ./configure --with-oniguruma=builtin && make \
#   && ln -sfv $PWD/jq.1 $ZI[MAN_DIR]/man1" sbin"jq" \
#     stedolan/jq

# tealdeer / tldr
# zi wait lucid as'program' from'gh-r' for \
#   mv'tealdeer* -> tealdeer' \
#   sbin'**/tealdeer -> tldr' \
#   pick'$ZPFX/bin/tldr' \
#   @tealdeer-rs/tealdeer
# zi ice lucid wait as'completion' blockf has'tldr' mv'zsh_tealdeer -> _tldr'
# zi snippet https://github.com/tealdeer-rs/tealdeer/blob/main/completion/zsh_tealdeer

# shellcheck
# zi wait lucid as'program' from'gh-r' for \
#   mv'shellcheck* -> shellcheck' \
#   sbin'**/shellcheck -> shellcheck' \
#   @koalaman/shellcheck

# # fzf, fd, bat, exa
# zi from"gh-r" as"null" for \
#   sbin"fzf" junegunn/fzf \
#   sbin"**/fd" @sharkdp/fd \
#   sbin"**/bat" @sharkdp/bat \
#   sbin"**/exa -> exa" atclone"cp -vf completions/exa.zsh _exa" ogham/exa

# yt-dlp
zi for as'program' nocompile'!' depth'1' \
  has'python' pick'$ZPFX/bin/youtube-dl*' make'!PREFIX=$ZPFX install' \
  atclone'ln -sfv youtube-dl.zsh _youtube-dl' atpull'%atclone' \
    ytdl-org/youtube-dl

# kubectx
# zi wait lucid for as"command" from"gh-r" \
#   bpick"kubectx;kubens" sbin"kubectx;kubens" \
#     ahmetb/kubectx

# zoxide
zi ice as'null' from"gh-r" sbin
zi light ajeetdsouza/zoxide
zi has'zoxide' light-mode for \
  z-shell/zsh-zoxide

# zsh-users/zsh-completions
zi ice lucid wait as'completion'
zi light zsh-users/zsh-completions

# zsh-users/zsh-autosuggestions
zi light zsh-users/zsh-syntax-highlighting

# g-plane/zsh-yarn-autocompletions
zi ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zi light g-plane/zsh-yarn-autocompletions

# g-plane/pnpm-shell-completion
zi ice atload"zpcdreplay" atclone"./zplug.zsh" atpull"%atclone"
zi light g-plane/pnpm-shell-completion
