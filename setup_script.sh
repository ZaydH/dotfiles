#!/usr/bin/env bash

GITHUB_BASE=https://github.com/ZaydH/
REPOS_DIR=~/repos/

# OS Related constants for comparison
MAC=Mac
LINUX=Linux

OS=ERROR # Define later
PKG_MNGR_INSTALL=ERROR # Defined later

function determine_os() {
    case "$OSTYPE" in
      solaris*) echo "SOLARIS" ;;
      darwin*)  OS=${MAC} ;;
      linux*)   OS=${LINUX} ;;
      bsd*)     echo "BSD" ;;
      msys*)    echo "WINDOWS" ;;
      *)        echo "unknown: $OSTYPE" ;;
    esac
}

function install_ohmyzsh() {
    printf "Installing Oh My ZSH..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null
    printf "COMPLETED\n"
}
function install_and_update_package_manager() {
    if [[ ${OS} -eq ${MAC} ]]; then
        install_brew
        PKG_MNGR_INSTALL=brew install
    else
        printf "No supported package manager. Exiting..."
        exit 1
    fi
}
# Used to install homebrew on a mac
function install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    printf "Updating brew..."
    brew update &> /dev/null
    printf "COMPLETED\n"
}
function install_package() {
    printf "Installing package \"${1}\"..."
    eval "${PKG_MNGR_INSTALL} ${1}"
    printf "COMPLETED\n"
}
# Installing the vim package manager vundle
function install_vim_package_manager() {
    printf "Installing vim package manager \"vundle\"..."
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    printf "COMPLETED\n"
    printf "Installing vim plugins..."
    vim -c 'PluginInstall' -c 'qa!' &> /dev/null
    printf "COMPLETED\n"
}

determine_os
install_and_update_package_manager

# Install package manager packages
declare -a pkgs=(gmp git bison gzip gcc autoconf automake cmake cppcheck
                 coreutils moreutils zsh vim tmux subversion wget)
for pkg in ${pkgs[@]}; do
    install_package pkg
done

install_ohmyzsh

# Link dotfiles
DOTFILES_REPO=dotfiles
mkdir -p REPOS_DIR &> /dev/null
cd $REPOS_DIR
printf "Cloning the ${DOTFILES_REPO} repo..."
rm -rf ${DOTFILES_REPO}i &> /dev/null
git clone ${GITHUB_BASEi}${DOTFILES_REPO} &> /dev/null
printf "COMPLETED\n"

INSTALL_SCRIPT="${DOTFILES_REPO}install_files.sh"
chmod +x ${INSTALL_SCRIPT}
printf "Installing the dot files..."
${INSTALL_SCRIPT} &> /dev/null
printf "COMPLETED\n"
# Return to previous directory
cd -

install_vim_package_manager

