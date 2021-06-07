#!/usr/bin/env bash

DOTFILES="$(pwd)"
PROJECTS=~/projects

COLOR_NONE="\033[0m"
COLOR_YELLOW="\033[1;33m"
COLOR_GREEN="\033[1;32m"
COLOR_PURPLE="\033[1;35m"
COLOR_GRAY="\033[1;38;5;243m"

function title() {
	echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
	echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

function error() {
	echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
	exit 1
}

function warning() {
	echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

function success() {
	echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

function usage() {
	echo -e "\nUsage: $0 <backup|link|git|homebrew|shell|macos|all>\n"
}

function setup_backup() {
	BACKUP_DIR=$HOME/dotfiles-backup

	title "Creating backup directory at $BACKUP_DIR"
	
	mkdir -p "$BACKUP_DIR"

	for file in "$HOME/.config/nvim" "$HOME/.vim" "$HOME/.vimrc"; do
	    if [ ! -L "$file" ]; then
            echo "backing up $file"
            cp -rf "$file" "$BACKUP_DIR"
        else
            warning "$file does not exist at this location or is a symlink"
        fi
    done
}

function setup_symlinks() {
	title "Setting up symbolic links"

	for file in $(find -H "$DOTFILES" -name '*.symlink'); do
		target="$HOME/.$(basename "$file" '.symlink')"
		if [ -e "$target" ]; then
			echo "~${target#$HOME} already exists...Skipping"
		else
			echo "Creating symlink for $file"
			ln -s "$file" "$target"
		fi
	done
}

function setup_git() {
	title "Setting up Git"
}

function setup_homebrew() {
	tile "Setting up Homebrew"
	
	if test ! "$(command -v brew)"; then
		echo "Homebrew not installed. Installing..."
		# Run as a login shell (non-interactive) so that the script doesn't pause for user input
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
    	fi
	
	# install brew dependencies from Brewfile
    	brew bundle
}

function setup_shell() {
	title "Configurating Shell"
}

[ ! -d "$PROJECTS" ] && echo "Creating projects directory..." && mkdir -p "$PROJECTS"

case "$1" in
	backup)
		setup_backup
		;;
	link)
		setup_symlinks
		;;
	git)
		setup_git
		;;
	hombrew)
		setup_homebrew
		;;
	shell)
		setup_shell
		;;
	all)
		setup_symlinks
		setup_homebrew
		setup_shell
		;;
	*)
		usage
		;;
esac

success "Done."
exit 0
