#!/usr/bin/env bash

PROJECTS=~/projects
BIN=~/bin

DOTFILES_DIRECTORY="${HOME}/.dotfiles"
DOTFILES_TARBALL_PATH="https://github.com/Nerconer/dotfiles/tarball/master"
DOTFILES_GIT_REMOTE="git@github.com:Nerconer/dotfiles.git"

echo ""

# If missing, download and extract the dotfiles repository
if [[ ! -d ${DOTFILES_DIRECTORY} ]]; then
    echo "Downloading dotfiles from repository..."
    mkdir ${DOTFILES_DIRECTORY}
    # Get the tarball
    curl -fsSLo ${HOME}/dotfiles.tar.gz ${DOTFILES_TARBALL_PATH}
    # Extract to the dotfiles directory
    tar -zxf ${HOME}/dotfiles.tar.gz --strip-components 1 -C ${DOTFILES_DIRECTORY}
    # Remove the tarball
    rm -rf ${HOME}/dotfiles.tar.gz
fi

cd ${DOTFILES_DIRECTORY}

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
cat <<EOT
	dotfiles - David Solà
	Usage: $(basename "$0") [options]
	Options:
			-h, --help	Print this help text
			backup     	Generates a Backup file
			link   			Configures all symlinks
			git       	Configures Git
			homebrew    Install dependencies
			shell       Configures Shell
			all       	Full setup and configuration
	Documentation can be found at https://github.com/Nerconer/dotfiles
	Copyright (c) David Solà
	Licensed under the MIT license.
EOT
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

	for file in $(find -H "$DOTFILES_DIRECTORY" -name '*.symlink'); do
		target="$HOME/.$(basename "$file" '.symlink')"
		if [ -e "$target" ]; then
			echo "~${target#$HOME} already exists...Skipping"
		else
			echo "Creating symlink for $file"
			ln -s "$file" "$target"
		fi
	done

	info "installing to ~/.config"
	if [ ! -d "$HOME/.config" ]; then
		info "Creating ~/.config"
		mkdir -p "$HOME/.config"
	fi
	
	config_files=$(find "$DOTFILES_DIRECTORY/config" -maxdepth 1 2>/dev/null)
	for config in $config_files; do
		target="$HOME/.config/$(basename "$config")"
		if [ -e "$target" ]; then
			info "~${target#$HOME} already exists... Skipping."
		else
			info "Creating symlink for $config"
			ln -s "$config" "$target"
		fi
	done

	if [ -e "$HOME/.vimrc" ]; then
		echo "./vimrc already exists... Skipping"
  else
		echo "Creating symlink for .vimrc"
		ln -s "$DOTFILES_DIRECTORY/config/nvim/init.vim" "$HOME/.vimrc"
  fi
}

function setup_scripts() {
	title "Setting up scripts"

	for file in $(find -H "$DOTFILES_DIRECTORY/scripts" -name '*.sh'); do
		target="$HOME/bin/$(basename "$file" '.sh')"
		if [ -e "$target" ]; then
			echo "~${target#$HOME} already exists...Skipping"
		else
			echo "Creating symlink for $file in $target" 
			ln -s "$file" "$target"
		fi
	done
}

function setup_git() {
	title "Setting up Git"

	defaultName=$(git config user.name)
	defaultEmail=$(git config user.email)

  read -rp "Name [$defaultName] " name
  read -rp "Email [$defaultEmail] " email

	git config -f ~/.gitconfig-local user.name "${name:-$defaultName}"
  git config -f ~/.gitconfig-local user.email "${email:-$defaultEmail}"
}

function setup_homebrew() {
	title "Setting up Homebrew"
	
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

	echo "Installing Oh My Zsh..."
	if [ ! -z $ZSH ]; then
		echo "Oh My Zsh already exists, skipping..."
	else
		mkdir oh-my-zsh-temp && cd $_
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	fi
}

[ ! -d "$PROJECTS" ] && echo "Creating projects directory..." && mkdir -p "$PROJECTS"

[ ! -d "$BIN" ] && echo "Creating ~/bin directory..." && mkdir "$BIN"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
	usage
	exit
fi

case "$1" in
	backup)
		setup_backup
		;;
	link)
		setup_symlinks
		setup_scripts
		;;
	git)
		setup_git
		;;
	homebrew)
		setup_homebrew
		;;
	shell)
		setup_shell
		;;
	all|*)
		setup_symlinks
		setup_scripts
		setup_shell
		setup_homebrew
		;;
esac

success "Done."
exit 0
