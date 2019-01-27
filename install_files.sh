#!/usr/bin/env bash

# Function for installing a file from then repository to the filesystem
function install_file() {
    # Get to the path of the script
    SCRIPT=`realpath $0`
    # Get the folder where the script is located
    SCRIPTPATH=`dirname $SCRIPT`
    # Get the relative folder for the item of interest
    DEST_FOLDER=$( dirname $1 )
    mkdir -p ~/${DEST_FOLDER} &> /dev/null
    printf "Creating symlink for file: \"$1\"\n"
    # unlink ~/$1 &> /dev/null  # Unlink the symlink if it exists
    rm ~/$1 &> /dev/null  # Remove an existing file if applicable
    # Create the symlink and delete item if it already exists
    ln -nsF ${SCRIPTPATH}/$1 ~/$1
}

install_file .gitconfig
install_file .pylintrc
install_file .vimrc
install_file .zshrc

# UltiSnips Plugin - LaTeX snippets
install_file .vim/UltiSnips
# Python packages for Python Imports vim module
install_file .vim/python-imports.cfg
# LaTeX specific vim settings
install_file .vim/ftplugin
# # Settings for latexmk Perl script
# install_file .latexmkrc
# Settings for tmux
install_file .tmux.conf
# Setup for flake8 syntax checker
install_file .config/flake8
# Setup vim key binds in Intelli-J IDEs
install_file .ideavimrc
# Configuration for google cloud
install_file .config/gcloud/configurations/config_default
