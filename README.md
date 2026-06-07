# Dotfiles

Personal shell, editor, and workflow configuration managed with GNU Stow.

## Layout

```text
nvim/.config/nvim/
ghostty/.config/ghostty/config
zsh/.zshrc
tmux/.tmux.conf
bin/.local/bin/tmux-sessioniser
```

## Install

```bash
cd ~/.dotfiles
stow nvim ghostty zsh tmux bin
```

## Workflow Notes

- [tmux + Neovim + Codex workflow](docs/tmux-neovim-codex-cheatsheet.md)
