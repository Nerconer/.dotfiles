#!/bin/bash
#
# Script to update all repositories at once

# Exit on fail
set -e

CURRENT_PATH="$(pwd)"


for f in */; do # Match only directories
    # $f is a directory
    printf "\n\n\n***** Updating '$f' *****\n"

    cd $f

    printf "\n  1. Fetching latest Repository version..."

    git fetch --all
    git checkout master
    git pull origin master

    printf "\n  2. Updated successfully"

	cd $CURRENT_PATH
done
