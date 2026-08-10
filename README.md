# github.com/lachieh/dotfiles

Dotfiles managed by [`mise`](https://mise.jdx.dev/) and
[`chezmoi`](https://github.com/twpayne/chezmoi).

Mise is the primary command surface and manages new, symlink-friendly files.
Chezmoi remains in place for the existing templates, encrypted files, and
machine profiles while they are migrated incrementally.

## Install

Run this:

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply lachieh
mise bootstrap dotfiles apply --yes
```

## Daily use

```shell
mise run dotfiles:status
mise run dotfiles:apply
mise run nvim:check
```

New mise-managed sources live under `mise-dotfiles/`. Existing chezmoi sources
retain their encoded names such as `dot_config/` until they are deliberately
migrated.
