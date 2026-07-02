# Enable Oh My Zsh options to disable auto-update, magic functions, and compfix
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Include ~/bin and ~/.local/bin scripts in PATH
# (Homebrew's PATH is set in ~/.zprofile, arch-aware)
export PATH=$HOME/bin:$HOME/.local/bin:$PATH

export TERM=xterm-256color

#autoload -U add-zsh-hook

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000000
SAVEHIST=$HISTSIZE
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.

setopt COMPLETE_ALIASES

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Add color and formatting to man pages and less command
export MANROFFOPT='-c'
export LESS='-R'
# Literal ANSI escapes (equivalent to the former tput calls, but with no
# subprocess cost at startup)
export LESS_TERMCAP_mb=$'\e[1m\e[32m'
export LESS_TERMCAP_md=$'\e[1m\e[36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1m\e[33m\e[44m'
export LESS_TERMCAP_se=$'\e[27m\e[0m'
export LESS_TERMCAP_us=$'\e[4m\e[1m\e[37m'
export LESS_TERMCAP_ue=$'\e[24m\e[0m'
export LESS_TERMCAP_mr=$'\e[7m'
export LESS_TERMCAP_mh=$'\e[2m'

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

plugins=(
  git
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)
source $ZSH/oh-my-zsh.sh
# If a local zshrc exists, source it. Make sure this is
# executed after oh-my-zsh so that local overrides are possible.
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

#export DOTFILES=~/.dotfiles/

# Load the shell dotfiles, and then some:
#if [ -d $DOTFILES ]; then
#	for file in $DOTFILES{exports,aliases,functions}; do
#		[ -r "$file" ] && [ -f "$file" ] && source "$file";
#	done;
#	unset file;
#fi

source ~/.zsh_profile

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# fnm is a Node.js version manager written in Rust
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

# opencode
export PATH=$HOME/.opencode/bin:$PATH

# mise (dev tools version manager)
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"


export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PYENV_ROOT/shims:$PATH"
# Lazy-load pyenv: full init (incl. auto-activation of virtualenvs on cd)
# only runs the first time `pyenv` is invoked in a session.
pyenv() {
  unfunction pyenv
  eval "$(command pyenv init - zsh)"
  eval "$(command pyenv virtualenv-init - zsh)"
  pyenv "$@"
}
