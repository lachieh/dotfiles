# github.com/lachieh/dotfiles

Dotfiles and machine setup managed by [mise](https://mise.jdx.dev/). This
repository is the global mise config: it is checked out at `~/.config/mise`,
and the files it deploys live in `dotfiles/`.

## Set up a machine

A Mac at your desk:

```sh
curl https://mise.run | sh
~/.local/bin/mise bootstrap --adopt lachieh/dotfiles --prompt-vars
mise run git:key          # this Mac's git key
mise run atuin:login      # 1Password CLI, Touch ID
mise run secrets:homelab  # homelab age key
mise run macos:system     # settings that need sudo
```

Any machine you can reach over SSH, run from a Mac with 1Password:

```sh
mise run machine:setup <host>
```

That installs mise on the host, checks this repo out there, installs tools,
applies dotfiles, copies `~/.ssh/config.d/`, sets up the machine's own git
key and registers it on GitHub, logs atuin in and writes the homelab age key. Secrets are read here with the 1Password CLI and sent over
SSH stdin.

## Agents profile

Machines that run coding agents select the `agents` profile
(`config.agents.toml`). Other machines never load it.

```sh
mise bootstrap -E agents --save-env    # this machine; remembered in miserc.local.toml
mise run agents:key                    # this machine's cliproxy key
mise run machine:setup <host> --agents # over SSH, including the key
```

The profile installs Claude Code, Codex and opencode as mise tools, and on
Linux installs T3 Code and runs it as a user service (the desktop app covers
macOS). Every CLI sends requests through cliproxy (CLIProxyAPI):

- Each machine has its own cliproxy key, in the 1Password item
  `cliproxy <hostname>` (Infrastructure vault), and on the machine only in
  `~/.config/cliproxy/key` (0600). `agents:key` creates the item and adds the
  key to cliproxy the first time, then reuses it.
- cliproxy's URL is not in this repo. It is `https://<subdomain>.<domain>`:
  the domain shared by all home infrastructure is in the 1Password item
  "Home infrastructure" (field `domain`), and each service's subdomain is on
  its own item (cliproxy's management item, field `subdomain`). `agents:key`
  writes the URL to `~/.config/cliproxy/url`, and the CLI config merges are
  templates that read it, so they merge nothing before the key is installed.
- The CLIs read the key file: Claude Code through `apiKeyHelper`, Codex through
  a provider `auth` command, opencode (v2 `providers` config) through
  `{file:...}`. Their config files get only the keys in `merges/agents/`
  merged in; everything the apps write themselves is left alone.
- A saved opencode login for OpenAI or Anthropic overrides the key, so
  `agents-setup` warns about one; remove it with `opencode auth logout openai`.
- T3 Code's provider instances point at the mise-installed binaries
  (`installs/<tool>/latest`), so they survive upgrades.

To retire a machine: delete its key in cliproxy, delete the 1Password item,
and run `mise bootstrap unapply agents` there.

## Daily use

```sh
mise run dotfiles:apply     # deploy changes from dotfiles/
mise run dotfiles:status    # drift, including edits to the locked shell files
mise bootstrap --update     # pull this repo and apply everything
mise run machine:setup <host> --update
mise run shell:check        # what each kind of shell gets
```

Edit files under `dotfiles/`. Most targets are symlinks into it, so edits show
up immediately. The shell startup files are copies and need `dotfiles:apply`.

## How it fits together

**Shell startup files are locked.** `~/.zshenv`, `~/.config/zsh/.zshenv`,
`.zprofile`, `.zshrc`, `~/.bashrc` and `~/.bash_profile` are read-only copies,
and on macOS immutable (`chflags uchg`), so installers cannot add lines to
them. `dotfiles:apply` unlocks them around each write. `ZDOTDIR` points zsh at
`~/.config/zsh`, so `~/.zshrc` and `~/.zprofile` are never read.

**Agents get the same CLI.** `~/.config/zsh/.zshenv` runs for every zsh,
including agent tool shells: mise tools, fnox secrets, git aliases and
functions. `.zshrc` adds only what a person at a prompt uses: completion,
prompt, history search, zoxide, fzf.

**No mise shims.** `mise activate` puts each tool's real directory on PATH for
the current directory. On macOS, `.zprofile` re-runs it after `path_helper`
reorders PATH in login shells.

**Git never prompts, and never sees your 1Password key.** Each machine has
its own git key, registered on GitHub for push and for signing, and listed in
`dotfiles/.config/git/allowed_signers`. If a machine is lost, revoke its key.

The key is a file generated on the machine, `~/.ssh/id_git`, used only for
GitHub. Anything running as you there can read it, which is the trade-off
for unattended signing; a leak means revoking that one key.

`git:key` writes `~/.ssh/git.conf` (the github.com host block) and
`~/.config/git/signing`, and `git/ssh-sign` keeps 1Password's agent out of
signing. Registering needs gh's key scopes once:
`gh auth refresh -s admin:public_key,admin:ssh_signing_key`.

**Other SSH uses 1Password.** Other machines use the forwarded agent, so
Touch ID prompts appear on the Mac you are at. Host entries are private and
live in `~/.ssh/config.d/`, outside the repo. `op` and fnox's 1Password
provider do not forward; atuin is logged in once per machine instead.

**Atuin.** Shell history records only your own commands. Agent commands are
captured by `atuin threads` through the daemon, which runs as a user service.

## Claude Code

Claude Code's Bash tool replays a shell snapshot with a fixed PATH, so a
project's pinned tool versions are lost (`mise run shell:check` shows this as
the `claude` row). `scripts/claude-env` writes mise's environment for the
current directory to `$CLAUDE_ENV_FILE`, which Claude runs before each
command. Add to `~/.claude/settings.json`:

```json
{
  "hooks": {
    "SessionStart": [{ "hooks": [{ "type": "command", "command": "~/.config/mise/scripts/claude-env" }] }],
    "CwdChanged": [{ "hooks": [{ "type": "command", "command": "~/.config/mise/scripts/claude-env" }] }]
  }
}
```

Not yet verified inside Claude Code: whether it runs `$CLAUDE_ENV_FILE` after
the snapshot. To check, start a session in a project that pins a tool version
different from the global one, and run `node --version` (or that tool) in the
Bash tool.

## Machine-specific config

`config.local.toml` and `tasks.local.toml` are not committed. Per-machine vars:

```sh
mise vars device_type=server     # prompt colours
mise vars computer_name=my-mac   # used by macos:system
```
