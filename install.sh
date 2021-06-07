#!/usr/bin/env bash

function usage() {
	echo -e "\nUsage: $0 <backup|link|git|homebrew|shell|macos|all>\n"
}

function setup_backup() {
	BACKUP_DIR=$HOME/dotfiles-backup

	echo "Creating backup directory at $BACKUP_DIR"
	
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
	echo "Settinh up symbolic links"
}

function setup_git() {
	echo "Setting up Git"
}

function setup_homebrew() {
	echo "Setting up Homebrew"
	
	if test ! "$(command -v brew)"; then
		echo "Homebrew not installed. Installing..."
		# Run as a login shell (non-interactive) so that the script doesn't pause for user input
		curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh | bash --login
    	fi
	
	# install brew dependencies from Brewfile
    	brew bundle
}

function setup_shell() {
	echo "Configurating Shell"
	
	
}

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

exit 0
