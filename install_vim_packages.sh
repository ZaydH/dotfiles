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

# function install_vim_coc_dependencies() {
#     printf "Installing NodeJS for vim's coc package...\n"
#     curl -sL install-node.now.sh/lts | bash
# }

function install_system_packages_for_neovim() {
    printf "Installing system packages for neovim..."
    sudo npm install -g neovim > /dev/null
    yarn global add neovim > /dev/null
    sudo gem install neovim > /dev/null
    gem environment > /dev/null
    printf "COMPLETED\n"
}

function install_vim_package_manager() {
    install_system_packages_for_neovim

    install_vundle
    install_vim_plug

    install_vim_coc_dependencies
}

function install_neovim_without_root() {
    # Downloads neovim manually
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
}


function install_node_without_root() {
    CUR_DIR=$(pwd)
    source "${HOME}/.zshrc"

    # create a directory where you want to install node js
    rm -rf "${NODE_HOME}" > /dev/null
    mkdir "${NODE_HOME}"
    cd "${NODE_HOME}"

    # download and extract nodejs binaries into the created directory
    printf "Downloading nodejs's latest binaries to ${NODE_HOME}...\n"
    wget https://nodejs.org/dist/node-latest.tar.gz
    tar -xzf node-latest.tar.gz
    mv node-v*/* .

    printf "Building nodejs...\n"
    ./configure --prefix=~/local
    make install # ok, fine, this step probably takes more than 30 seconds...
    printf "Downloading npm...\n"
    curl https://www.npmjs.org/install.sh | sh

    # refresh environment variables
    source "${HOME}/.zshrc"

    cd "${CUR_DIR}"
}
