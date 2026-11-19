# Neovim configuration

This is a deliberately small personal configuration for Neovim 0.12+. It uses
Neovim's native `vim.pack` plugin manager and keeps its generated
`nvim-pack-lock.json` under version control.

## Start here

- Run `nvim`, then `:Tutor` for the interactive editing tutorial.
- Run `mise run nvim:sync` once to finish installing Treesitter parsers.
- Press Space and pause to see available leader-key actions.
- Use `Space f f` for files, `Space f g` for text, and `Space e` for the file
  explorer.
- Use `Space c f` to format and `Space g b` to inspect Git blame.
- Use `:checkhealth` when something does not work.
- Use `:help <topic>` for Neovim's built-in documentation.

Native LSP completion appears when a language server is available on `PATH`.
Use `Ctrl-Space` to request completion and `Ctrl-y` to accept an item. Neovim's
LSP mappings include `gd` for definitions, `K` for documentation, `grr` for
references, `Space c r` for rename, and `Space c a` for code actions.

## Maintenance

- `mise run nvim:check` verifies a clean headless startup.
- `mise run nvim:sync` installs any missing plugins and parsers.
- `:lua vim.pack.update()` updates plugins and rewrites `nvim-pack-lock.json`
  after confirmation.
- `:TSUpdate` updates Treesitter parsers after plugin updates.
- Commit configuration changes and the lockfile together.

Use `NVIM_APPNAME=another-profile nvim` if you later want an isolated profile
stored at `~/.config/another-profile`. Until there is a concrete need for one,
keep a single profile and use `nvim --clean` to troubleshoot without it.
