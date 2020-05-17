#!/usr/bin/env bash

source .functions

# Installing the vim package manager vundle
function install_vundle() {
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

function install_vim_plug() {
    printf "Installing vim package manager \"vim-plug\"..."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
           https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' > /dev/null
    printf "COMPLETED\n"
}

function install_vim_package_manager() {
    install_vundle
    install_vim_plug
}
