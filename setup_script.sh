#!/usr/bin/env bash

# Installing the vim package manager vundle
function install_vim_package_manager() {
    VIM_BUNDLE_FOLDER=~/.vim/bundle/
    printf "Installing vim package manager \"vundle\"..."
    rm -rf ${VIM_BUNDLE_FOLDER} > /dev/null
    git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_BUNDLE_FOLDER}Vundle.vim > /dev/null
    printf "COMPLETED\n"
    printf "Installing vim plugins..."
    vim -c 'PluginInstall' -c 'qa!' # > /dev/null
    printf "COMPLETED\n"

    YCM=YouCompleteMe
    printf "Installing ${YCM}..."
    cd ${VIM_BUNDLE_FOLDER}${YCM}
    python install.py > /dev/null
    cd -
    printf "COMPLETED\n"
}

function install_python_with_pyenv() {
    source ~/.zshrc > /dev/null
    install_cli_package pyenv

    printf "Updating PyEnv..."
    pyenv update > /dev/null
    printf "COMPLETED\n"

    # Needed to ensure configuration is valid
    export PYTHON_CONFIGURE_OPTS="--enable-framework"
    declare -a versions=("2.7.15" "3.6.5" "3.7.2")
    for ver in ${versions[@]}; do
        printf "Installing python version ${ver}..."
        cmd="pyenv install ${ver}"
        eval ${cmd} > /dev/null
        printf "COMPLETED\n"
        pyenv global ${ver}
        printf "Upgrading pip..."
        printf "COMPLETED\n"
        ./install_pip_packages.sh
    done
}

function setup_dot_files() {
    LINK_FILES_SCRIPT="./link_files.sh"
    printf "Linking the dot files..."
    eval ${LINK_FILES_SCRIPT} > /dev/null
    printf "COMPLETED\n"
    # Load the zshrc file for better support
    source ~/.zshrc
}

# Enable Jupyter Extensions
function install_jupyter_extensions() {
    ./install_jupyter_extensions.sh
}

source .functions
determine_os
source install_packages.sh
source install_tex.sh
source install_tmux.sh
source install_zsh.sh

# install_and_update_package_manager
# install_all_packages

# install_tex

# install_oh_my_tmux
# install_tmux_packages

# setup_dot_files

# install_python_with_pyenv

install_vim_package_manager

# install_jupyter_extensions

#=====================================================
# Do last to prevent conflicts between shells
#=====================================================
# install_oh_my_zsh
# setup_dot_files
