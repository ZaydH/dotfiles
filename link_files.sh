#!/usr/bin/env bash

# Function for installing a file from then repository to the filesystem
function install_file() {
    if [ $# == 1 ]; then
        DEST_FILE=$1
    elif [ $# == 2 ]; then
        DEST_FILE=$2
    else
        printf "Unsupported number of input arguments\n"
        exit
    fi
    SRC_FILE=$1
    # Get to the path of the script
    SCRIPT=`realpath $0`
    # Get the folder where the script is located
    SCRIPTPATH=`dirname $SCRIPT`
    # Get the relative folder for the item of interest
    DEST_FOLDER=$( dirname ${SRC_FILE} )
    mkdir -p ~/${DEST_FOLDER} &> /dev/null
    printf "Creating symlink for file: \"${SRC_FILE}\"\n"
    # unlink ~/${SRC_FILE} &> /dev/null  # Unlink the symlink if it exists
    rm ~/${DEST_FILE} &> /dev/null  # Remove an existing file if applicable
    # Create the symlink and delete item if it already exists
    ln -nsF ${SCRIPTPATH}/${SRC_FILE} ~/${DEST_FILE}
}

# Git settings
install_file .gitconfig
# Set of files git will always ignore
install_file .gitignore_global

install_file .pylintrc
install_file .vimrc
install_file .zshrc
if [[ $(hostname) == *"talapas"* ]]; then
    install_file .bashrc_talapas .bashrc
fi

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
# Adding jupyter notebook configuration
install_file .jupyter/jupyter_notebook_config.py
# Add the dictionary file
install_file .vim/spell/en.utf-8.add
# Add the file containing shell functions
install_file .functions
# Add the file containing shell aliases
install_file .aliases
# Add the file containing ssh/scp configuration
install_file .ssh/config
install_file .ssh/id_rsa.pub
