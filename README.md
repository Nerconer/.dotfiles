# .dotfiles

Personal dotfiles for macOS and Linux: zsh (oh-my-zsh), git, tmux, neovim and nano, managed with [GNU Stow](https://www.gnu.org/software/stow/) symlinks and a `Brewfile` for packages.

## Install

One-liner (downloads the repo to `~/.dotfiles` and runs the full setup):

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Nerconer/.dotfiles/main/install)"
```

Or clone it yourself:

```bash
git clone git@github.com:Nerconer/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install
```

The full setup (`./install` or `./install all`) does, in order:

1. **homebrew** — installs Homebrew if missing and the packages in `Brewfile`
2. **link** — symlinks all configs into `$HOME` with stow (existing real files are moved to `*.backup`)
3. **shell** — installs oh-my-zsh + external plugins and sets zsh as the default shell
4. **git** — asks for your name/email and writes them to `~/.gitconfig.local`

Each step can be run on its own: `./install homebrew|link|shell|git|backup`.

When it finishes, restart your terminal (or `exec zsh -l`).

## Local customizations

Machine-specific config lives outside version control and is loaded automatically if present:

- `~/.gitconfig.local` — git identity (created by `./install git`)
- `~/.zshrc.local` — private env vars and aliases, sourced at the end of `.zshrc`

## Notes

- **Windows**: use `Windows Terminal` + `WSL2` and follow the Linux path. Font: [JetBrains Mono](https://www.jetbrains.com/lp/mono/#how-to-install), size 12.
- **zsh not loading on Linux**: `sudo apt install zsh`, check it appears in `/etc/shells`, then `chsh -s $(which zsh)` and log out/in.
