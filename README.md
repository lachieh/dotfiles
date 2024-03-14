# github.com/lachie/dotfiles

dotfiles, managed with [`chezmoi`](https://github.com/twpayne/chezmoi).

## Install

This'll install Homebrew and chezmoi. After installation `chezmoi` will be initialized.

```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/lachieh/dotfiles/main/install.sh)"
```

## Manual install

Prerequisite: Homebrew & chezmoi

```shell
# Setup
chezmoi init https://github.com/lachie/dotfiles.git

# Configure ~/.config/chezmoi/chezmoi.toml
chezmoi init
```
