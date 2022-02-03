# dotfiles
Dotfiles, configurations, and general workspace setup. Because every dev should have one.

## How to install
```bash
$ bash -c "$(curl -fsSL raw.github.com/Nerconer/dotfiles/master/install.sh)"
```

## git-aliases
Configure Notepad++ as the default text editor:
```bash
git config --global core.editor "'C:\Program Files (x86)\Notepad++\notepad++.exe'"
```
Configure Visual Studio Code as the default text editor:
```bash
git config --global core.editor "code --wait"
```
These are the personal git aliases I use (by placing them in `git config --global -e`). Feel free to steal or ignore them. :satisfied:
