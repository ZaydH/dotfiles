#!/usr/bin/env bash

# Installing the vim package manager vundle
function install_vim_package_manager() {
    VIM_BUNDLE_FOLDER="${HOME}/.vim/bundle"
    printf "Installing vim package manager \"vundle\"..."
    rm -rf "${VIM_BUNDLE_FOLDER}" > /dev/null

    VUNDLE_REPO=https://github.com/VundleVim/Vundle.vim.git
    git clone "${VUNDLE_REPO}" "${VIM_BUNDLE_FOLDER}/Vundle.vim" > /dev/null
    printf "COMPLETED\n"
    printf "Installing vim plugins..."
    vim -c 'PluginInstall' -c 'qa!' # > /dev/null
    printf "COMPLETED\n"

    # YCM=YouCompleteMe
    # printf "Installing ${YCM}..."
    # cd ${VIM_BUNDLE_FOLDER}${YCM}
    # python install.py > /dev/null
    # cd -
    # printf "COMPLETED\n"
}

function setup_dot_files() {
    LINK_FILES_SCRIPT="./link_files.sh"
    printf "Linking the dot files..."
    eval ${LINK_FILES_SCRIPT} > /dev/null
    printf "COMPLETED\n"
    # Load the zshrc file for better support
    source "${HOME}/.zshrc"
}

# Enable Jupyter Extensions
function install_jupyter_extensions() {
    ./install_jupyter_extensions.sh
}

source .functions
determine_os
source install_packages.sh
source install_python.sh
source install_tex.sh
source install_tmux.sh
source install_zsh.sh

# install_all_packages

# install_tex

# install_oh_my_tmux

# install_oh_my_zsh

# install_python_with_pyenv

# install_vim_package_manager

# install_jupyter_extensions

# setup_dot_files
