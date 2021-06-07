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

}

function setup_git() {
	echo "Setting up Git"
}

function setup_homebrew() {

}

function setup_shell() {

}

case "$1" in
	backup)
		echo "backup"
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
