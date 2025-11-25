# TODOS

- [ ] move to mise for tool installs?
	- [ ] good because os dependent
	- [ ] https://mise.jdx.dev/dev-tools/#os-specific-tools
- [ ] add something to prompt when connecting over ssh
- [ ] switch 1password to use service account
  - add service account creds to encrypted age file
  - update 1password config to use service account
- [ ] setup raycast
- [ ] setup alfred
- [ ] setup istatmenus
- [ ] add items to startup (check existing)
- [ ] unquarantine on install:
  - [ ] `/Applications/QLMarkdown.app`
  - [ ] `/Applications/Syntax Highlight.app`
- [ ] update macos settings plist
    ```sh
    defaults read >/tmp/defaults_MacOS_10.10.5.orig
    defaults read >/tmp/defaults_MacOS_10.10.5.modified

    diff defaults_MacOS_10.10.5.{orig,modified} | more
    ```
- [ ] configure obsidian vault
- [ ] add betterdisplay (remove monitorcontrol)
- [ ] jordanbaird/ice
- [ ] iina set as default for apps (maybe settings plist?)
