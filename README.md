# Dotfiles

Managed with **GNU Stow** — each top-level dir is a *package*; `stow <pkg>` symlinks its contents into `~`.

## Packages

| Package | What | Links to |
|---|---|---|
| `nvim` | editor | `~/.config/nvim/` |
| `ghostty` | terminal | `~/.config/ghostty/config` |
| `tmux` | multiplexer | `~/.tmux.conf` |
| `zsh` | shell | `~/.zshrc` |
| `aerospace` | tiling WM | `~/.aerospace.toml` |
| `firefox` | hardened `user.js` | Firefox profile (see Install) |
| `bin` | scripts | `~/.local/bin/` |

## Install

```bash
cd ~/.dotfiles
stow nvim ghostty zsh tmux bin aerospace

# Firefox: profile folder name is machine-specific — check ~/.../Firefox/profiles.ini
stow --target="$HOME/Library/Application Support/Firefox/Profiles/Y10nADT7.Profile 1" firefox
```

## AeroSpace (mod = `⌥` Option)

Workspaces: **1** Claude · **2** Ghostty · **3** Firefox · **4** Obsidian · **5–8** free · **9** Codex

Full key reference → [docs/motions-cheatsheet.md](docs/motions-cheatsheet.md)

**Pin a new app** — get its bundle id and add a block to `aerospace/.aerospace.toml`:
```bash
mdls -name kMDItemCFBundleIdentifier -raw /Applications/<App>.app
```
```toml
[[on-window-detected]]
if.app-id = '<bundle-id>'
run = 'move-node-to-workspace <N>'
```

## See also

- [Motions cheatsheet](docs/motions-cheatsheet.md) — AeroSpace · tmux · Neovim keys in one place
- macOS settings changed + AeroSpace gotchas → Obsidian `03 Resources/macos/aerospace.md`
