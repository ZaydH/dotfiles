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
    mkdir -p ~/${DEST_FOLDER} > /dev/null
    printf "Creating symlink for file: \"${SRC_FILE}\"\n"
    # unlink ~/${SRC_FILE} > /dev/null  # Unlink the symlink if it exists
    rm -rf ~/${DEST_FILE} > /dev/null  # Remove an existing file if applicable
    # Create the symlink and delete item if it already exists
    ln -nsF ${SCRIPTPATH}/${SRC_FILE} ~/${DEST_FILE}
}

# Git settings
install_file .gitconfig
# Set of files git will always ignore
install_file .gitignore_global

# Command line zsh related settings
install_file .zshrc
# Add the file containing shell functions
install_file .functions
# Add the file containing shell aliases
install_file .aliases
# oh-my-zsh auto-completions
install_file .oh-my-zsh/completions
# Special bash file used to load zsh on Talapas
if [[ $(hostname) == *"talapas"* ]]; then
    install_file .bashrc_talapas .bashrc
fi

# Vim related files
install_file .vimrc
# UltiSnips Plugin - LaTeX snippets
install_file .vim/UltiSnips
# Python packages for Python Imports vim module
install_file .vim/python-imports.cfg
# LaTeX specific vim settings
install_file .vim/ftplugin
# Add the dictionary file
install_file .vim/spell/en.utf-8.add
# Setup vim key binds in Intelli-J IDEs
install_file .ideavimrc
# ctags settings file
install_file .ctags

# Pylint settings
install_file .pylintrc
# Setup for flake8 syntax checker
install_file .config/flake8
# Adding jupyter notebook configuration
install_file .jupyter/jupyter_notebook_config.py

# # Settings for latexmk Perl script
# install_file .latexmkrc
# Settings for tmux
source install_tmux.sh
install_file "${OH_MY_TMUX_REPO_NAME}/.tmux.conf" .tmux.conf
install_file ${TMUX_CONF_LOCAL}
install_file .tmux
# # Configuration for google cloud
# install_file .config/gcloud/configurations/config_default
# Add the file containing ssh/scp configuration
install_file .ssh/config
install_file .ssh/id_rsa.pub
