# Include ~/bin scripts in PATH
export PATH=$HOME/bin:$PATH
# Include Homebrew in PATH
export PATH=/usr/local/bin:/usr/local/sbin:$PATH

TERM=xterm-256color

# initialize autocomplete
autoload -U compinit add-zsh-hook
compinit

# history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt EXTENDED_HISTORY          # write the history file in the ":start:elapsed;command" format.
setopt HIST_REDUCE_BLANKS        # remove superfluous blanks before recording entry.
setopt SHARE_HISTORY             # share history between all sessions.
setopt HIST_IGNORE_ALL_DUPS      # delete old recorded entry if new entry is a duplicate.

setopt COMPLETE_ALIASES

# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# If a local zshrc exists, source it
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# add color to man pages
export MANROFFOPT='-c'
export LESS_TERMCAP_mb=$(tput bold; tput setaf 2)
export LESS_TERMCAP_md=$(tput bold; tput setaf 6)
export LESS_TERMCAP_me=$(tput sgr0)
export LESS_TERMCAP_so=$(tput bold; tput setaf 3; tput setab 4)
export LESS_TERMCAP_se=$(tput rmso; tput sgr0)
export LESS_TERMCAP_us=$(tput smul; tput bold; tput setaf 7)
export LESS_TERMCAP_ue=$(tput rmul; tput sgr0)
export LESS_TERMCAP_mr=$(tput rev)
export LESS_TERMCAP_mh=$(tput dim)

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git zsh-autosuggestions z)

source $ZSH/oh-my-zsh.sh

#export DOTFILES=~/.dotfiles/

# Load the shell dotfiles, and then some:
#if [ -d $DOTFILES ]; then
#	for file in $DOTFILES{exports,aliases,functions}; do
#		[ -r "$file" ] && [ -f "$file" ] && source "$file";
#	done;
#	unset file;
#fi

source ~/.zsh_profile

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
