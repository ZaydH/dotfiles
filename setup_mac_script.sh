#!/usr/bin/env bash

GITHUB_BASE=https://github.com/ZaydH/
REPOS_DIR=~/repos/

function install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    printf "Updating brew\n"
    brew update &> /dev/null
    printf "Brew update complete\n"
}
function install_package() {
    PKG_MNGR_INSTALL=brew install
    printf "Installing package \"${1}\""
    eval "${PKG_MNGR_INSTALL} ${1}"
}

# Install package manager packages
declare -a pkgs=(gmp git bison gzip gcc autoconf automake cmake cppcheck
                 coreutils moreutils zsh vim tmux subversion)
for pkg in ${pkgs[@]}; do
    install_package pkg
done

DOTFILES_REPO=dotfiles
mkdir -p REPOS_DIR &> /dev/null
cd $REPOS_DIR
printf "Cloning the ${DOTFILES_REPO} repo...\n"
git clone $GITHUB_BASE$DOTFILES_REPO
INSTALL_SCRIPT="install_files.sh"
chmod +x $DOTFILES_REPO/$INSTALL_SCRIPT
printf "Installing the dot files..."
$_
