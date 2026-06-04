# tmux + Neovim + Codex Cheatsheet

This is the working model from the tutorial captions, adapted to your setup:

- Left side of the screen: terminal running `tmux`.
- Right side of the screen: browser.
- Inside tmux: jump between project sessions such as `codex`, `nvim`, `server`, and quick shells.
- For a .NET project: keep one tmux session/window running `dotnet watch run`.

## Most Important Things

### The Mental Model

tmux is a long-running workspace server.

Your terminal window can close, but tmux keeps sessions alive in the background. Reopen a terminal and reattach.

Hierarchy:

```text
tmux server
  session: one project or focused context
    window: one task inside that project
      pane: one shell/process visible inside a window
```

Use sessions for projects/contexts. Use windows for tasks. Use panes only when you want side-by-side output.

### Daily Muscle Memory

Default prefix is:

```text
Ctrl-b
```

After pressing the prefix, release it, then press the command key.

| Goal | Keys / Command |
| --- | --- |
| Start tmux | `tmux` |
| Attach to existing tmux | `tmux a` |
| List sessions | `tmux ls` |
| Detach without killing work | `prefix d` |
| Kill current shell/window/pane | `Ctrl-d` or `exit` |
| Session/window picker | `prefix w` |
| Jump to previous session | `prefix L` |
| New window | `prefix c` |
| Next window | `prefix n` |
| Previous window | `prefix p` |
| Jump to window 1/2/3 | `prefix 1`, `prefix 2`, `prefix 3` |
| Split left/right | `prefix %` |
| Split top/bottom | `prefix "` |
| Enter copy mode | `prefix [` |

The big one: `prefix L` is your "bounce back" key. Use it like Vim alternate file: jump to another session, do a quick thing, then `prefix L` back.

## Your Preferred Layout

Use the operating system/window manager to split the screen:

```text
+-------------------------------+-------------------------------+
| Left: terminal + tmux          | Right: browser                |
|                               |                               |
| codex / claude / shell / nvim  | localhost app, docs, preview  |
| dotnet watch run session       |                               |
+-------------------------------+-------------------------------+
```

The browser does not need to be inside tmux. Keep it as a normal browser window on the right. tmux owns the left terminal.

## Recommended Session Setup

For each project, create named sessions:

```bash
tmux new -s my-project -c /path/to/my-project
```

Inside that project session, create windows:

```text
1: codex       # Codex or Claude Code
2: nvim        # Neovim in the project
3: server      # dotnet watch run / npm run dev / tests
4: shell       # spare terminal
```

Example commands:

```bash
tmux new -s my-project -c /path/to/my-project
```

Then inside tmux:

```text
prefix ,       rename current window to codex
codex          start Codex

prefix c       new window
prefix ,       rename to nvim
nvim .

prefix c       new window
prefix ,       rename to server
dotnet watch run

prefix c       new window
prefix ,       rename to shell
```

Now use:

```text
prefix 1       Codex / Claude Code
prefix 2       Neovim
prefix 3       server
prefix 4       shell
```

Keep the browser on the right pointed at your app, e.g.:

```text
http://localhost:5000
http://localhost:5173
http://localhost:3000
```

## Project Jumping With a Sessionizer

The tutorial's important upgrade is a "sessionizer":

1. Fuzzy-find a project folder.
2. Turn the folder name into a tmux session name.
3. If the session does not exist, create it in that directory.
4. Switch to it.

Minimal version:

```bash
#!/usr/bin/env bash

selected="$(fd . "$HOME/personal" "$HOME/work" "$HOME" -t d -d 1 | fzf)"

if [[ -z "$selected" ]]; then
  exit 0
fi

session_name="$(basename "$selected" | tr . _)"

if ! tmux has-session -t="$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"
fi

tmux switch-client -t "$session_name"
```

Put it somewhere on your PATH, for example:

```text
~/.local/bin/tmux-sessionizer
```

In this dotfiles repo there is already a local script with the British spelling:

```text
~/.dotfiles/bin/.local/bin/tmux-sessioniser
```

That script searches `~/personal`, `~/work`, `~/.dotfiles`, `~/.dotfiles/.config`, and `~/projects`, then creates or switches to a matching tmux session.

Bind whichever script name is installed on your PATH:

```tmux
bind-key f display-popup -E "tmux-sessioniser"
```

After reloading tmux config:

```text
prefix f       fuzzy-pick a project/session
prefix L       jump back to the previous session
```

## Dotfiles in One Place With Stow

This is the "all config lives in one repo, then symlink it into place" part.

The tool is GNU Stow. It manages symlinks. Your real files live in a dotfiles repo, and Stow creates links from the places programs expect back into that repo.

Current repo shape:

```text
~/.dotfiles/
  nvim/
    .config/
      nvim/
        init.lua
  bin/
    .local/
      bin/
        tmux-sessioniser
  zsh/
    .zshrc
```

Current observed links:

```text
~/.config/nvim                 ->  ~/.dotfiles/nvim/.config/nvim
~/.tmux.conf                   ->  ~/.dotfiles/tmux/.tmux.conf
~/.zshrc                       ->  ~/.dotfiles/zsh/.zshrc
~/.local/bin/tmux-sessioniser  ->  ~/.dotfiles/bin/.local/bin/tmux-sessioniser
```

That means the apps still see their normal home-directory locations, but you edit/commit the real files in `~/.dotfiles`.

Install Stow:

```bash
brew install stow
```

or:

```bash
sudo apt install stow
```

Create the repo shape:

```bash
mkdir -p ~/.dotfiles/nvim/.config/nvim
mkdir -p ~/.dotfiles/tmux
mkdir -p ~/.dotfiles/zsh
mkdir -p ~/.dotfiles/bin/.local/bin
```

If you are starting from normal files in `$HOME`, move configs into the repo:

```bash
mv ~/.config/nvim/init.lua ~/.dotfiles/nvim/.config/nvim/init.lua
mv ~/.tmux.conf ~/.dotfiles/tmux/.tmux.conf
mv ~/.zshrc ~/.dotfiles/zsh/.zshrc
mv ~/.local/bin/tmux-sessioniser ~/.dotfiles/bin/.local/bin/tmux-sessioniser
```

If you are adapting an older repo shape where Neovim lives at `~/.dotfiles/.config/nvim`, move that directory into the `nvim` package before stowing:

```bash
mkdir -p ~/.dotfiles/nvim/.config
mv ~/.dotfiles/.config/nvim ~/.dotfiles/nvim/.config/nvim
```

Then from inside the dotfiles repo:

```bash
cd ~/.dotfiles
stow nvim tmux zsh bin
```

Important: when you run `stow nvim` from `~/.dotfiles`, Stow links the contents of `~/.dotfiles/nvim` into the parent directory, `~`.

So this:

```text
~/.dotfiles/nvim/.config/nvim/init.lua
```

becomes visible here:

```text
~/.config/nvim/init.lua
```

but as a symlink.

### Stow Commands

| Goal | Command |
| --- | --- |
| Link one package | `stow nvim` |
| Link several packages | `stow nvim tmux zsh bin` |
| Remove symlinks for one package | `stow -D nvim` |
| Restow after changes | `stow -R nvim` |
| Preview what would happen | `stow -n -v nvim` |
| Use a specific target | `stow -t "$HOME" nvim` |

### Rules of Thumb

- Each top-level folder under `~/.dotfiles` is a Stow package.
- Inside each package, mirror the path you want under `$HOME`.
- Commit `~/.dotfiles` to git.
- Edit the files in the repo, not random copies elsewhere.
- If Stow refuses, there is probably already a real file at the target path. Move it into the repo first, or back it up.

For your tmux setup, the useful packages are probably:

```text
~/.dotfiles/
  tmux/
    .tmux.conf
  nvim/
    .config/nvim/init.lua
  zsh/
    .zshrc
  bin/
    .local/bin/tmux-sessioniser
```

Then:

```bash
cd ~/.dotfiles
stow tmux nvim zsh bin
```

## Useful tmux Config

Edit:

```text
~/.tmux.conf
```

Good basics:

```tmux
set -g base-index 1
setw -g pane-base-index 1

bind r source-file ~/.tmux.conf \; display-message "tmux config reloaded"

bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

bind-key f display-popup -E "tmux-sessioniser"
```

Reload with:

```text
prefix r
```

Or from shell:

```bash
tmux source-file ~/.tmux.conf
```

## Copy Mode

Enter scroll/copy mode:

```text
prefix [
```

If configured for vi-style copy:

```text
j/k       move
Ctrl-u    half-page up
Ctrl-d    half-page down
v         start selection
y         yank/copy
q         quit copy mode
```

On macOS clipboard integration usually uses `pbcopy`; Linux often uses `xclip` or `wl-copy`.

## Neovim Role

Use Neovim as the code inspection/editing window:

```bash
nvim .
```

Useful habit:

```text
prefix 2       go to nvim
prefix 1       go back to Codex/Claude
prefix 3       check server logs
browser        inspect the result on the right
```

The course mentions putting project/session navigation on a keybinding from Vim too. The point is: whether you are in shell or Neovim, you should be able to quickly open the project picker.

## .NET Project Flow

For a .NET app:

```text
Left terminal/tmux
  window 1: codex
  window 2: nvim .
  window 3: dotnet watch run
  window 4: shell

Right browser
  app running on localhost
```

Commands:

```bash
tmux new -s my-dotnet-app -c /path/to/my-dotnet-app
```

Then:

```text
prefix ,       rename to codex
codex

prefix c
prefix ,       rename to nvim
nvim .

prefix c
prefix ,       rename to server
dotnet watch run
```

Switch all day:

```text
prefix 1       ask/work with Codex
prefix 2       inspect/edit in Neovim
prefix 3       see dotnet watch output
prefix L       bounce to previous session
```

## When Things Feel Lost

Use these:

```bash
tmux ls
```

```text
prefix w
```

Attach:

```bash
tmux a
tmux attach -t my-project
```

Kill only when you really mean it:

```bash
tmux kill-session -t my-project
tmux kill-server
```

`tmux kill-server` kills everything tmux is keeping alive. Treat it as the big red button.
