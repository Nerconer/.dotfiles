# Enable Oh My Zsh options to disable auto-update, magic functions, and compfix
DISABLE_AUTO_UPDATE="true"
DISABLE_MAGIC_FUNCTIONS="true"
DISABLE_COMPFIX="true"

# Include ~/bin scripts in PATH
export PATH=$HOME/bin:$PATH
# Include Homebrew in PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

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
if command -v tput >/dev/null 2>&1; then
  export LESS_TERMCAP_mb="$(tput bold; tput setaf 2)"
  export LESS_TERMCAP_md="$(tput bold; tput setaf 6)"
  export LESS_TERMCAP_me="$(tput sgr0)"
  export LESS_TERMCAP_so="$(tput bold; tput setaf 3; tput setab 4)"
  export LESS_TERMCAP_se="$(tput rmso; tput sgr0)"
  export LESS_TERMCAP_us="$(tput smul; tput bold; tput setaf 7)"
  export LESS_TERMCAP_ue="$(tput rmul; tput sgr0)"
  export LESS_TERMCAP_mr="$(tput rev)"
  export LESS_TERMCAP_mh="$(tput dim)"
fi

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

# Conda portable & light setup
export CONDA_AUTO_ACTIVATE_BASE=false

if command -v conda >/dev/null 2>&1; then
  eval "$(conda shell.zsh hook)"
else
  # Fallback si aún no está en PATH
  if [[ -f "$HOME/anaconda3/etc/profile.d/conda.sh" ]]; then
    . "$HOME/anaconda3/etc/profile.d/conda.sh"
  elif [[ -d "$HOME/anaconda3/bin" ]]; then
    export PATH="$HOME/anaconda3/bin:$PATH"
  fi
fi

# session-wise fix
ulimit -n 4096
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

# fnm is a Node.js version manager written in Rust
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

