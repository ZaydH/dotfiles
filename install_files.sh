#!/usr/bin/env bash

# Function for installing a file from then repository to the filesystem
function install_file() {
    SCRIPT=`realpath $0`
    SCRIPTPATH=`dirname $SCRIPT`
    DEST_FOLDER=$( dirname $1 )
    mkdir -p ~/${DEST_FOLDER} &> /dev/null
    printf "Creating symlink for file: \"$1\"\n"
    ln -sf ${SCRIPTPATH}/$1 ~/$1
}

install_file .gitconfig
install_file .pylintrc
install_file .vimrc
install_file .zshrc

# UltiSnips Plugin - LaTeX snippets
install_file .vim/UltiSnips/tex.snippets
# Python packages for Python Imports vim module
install_file .vim/python-imports.cfg
# LaTeX specific vim settings
install_file .vim/ftplugin/tex.vim
# Settings for latexmk Perl script
install_file .latexmkrc
# Settings for tmux
install_file .tmux.conf
# Setup for flake8 syntax checker
install_file .config/flake8
# Setup vim key binds in Intelli-J IDEs
install_file .ideavimrc
