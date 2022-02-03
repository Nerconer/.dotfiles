#!/usr/bin/env bash

# Exit on fail
set -e

echo $@

bash "${HOME}/.dotfiles/install.sh" $@