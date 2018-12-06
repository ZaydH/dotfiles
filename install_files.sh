#!/usr/bin/env bash

# Function for installing a file from then repository to the filesystem
function install_file() {
    printf "Creating sylink for file: \"$1\"\n"
    ln -sf $1 ~/$1
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
install_file ./latexmkrc
