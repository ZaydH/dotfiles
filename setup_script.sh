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
# Installs one package via the package manager
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
function install_python_with_pyenv() {
    declare -a versions={"2.7.14" "3.6.5" "3.7.1"}
    for ver in ${versions[@]}; do
        printf "Installing python version ${ver}..."
        pyenv install ${ver} &> /dev/null
        printf "COMPLETED\n"
        printf "Beginning pip install..."
        pip install --upgrade pip &> /dev/null
        printf "COMPLETED\n"
        install_python_packages
    done
}
# Standard function for install packages using pip
function install_python_packages() {
    declare -a pip_pkgs=(torch torchtext torchvision torchnet tensorflow tflearn sklearn numpy
                         scipy pillow ipython pandas git-wrapper quilt bedtools dill matplotlib
                         exhale sphinx exhale sphinx_rtd_theme lightgbm dill seaborn jupyter
                         fuzzywuzzy)
    for pkg in ${pip_pkgs[@]}; do
        printf "Installing python package \"${pkg}\"..."
        pip install pkg &> /dev/null
        printf "COMPLETED\n"
    done
}


determine_os
install_and_update_package_manager

# Install package manager packages
declare -a pkgs=(gmp git bison gzip gcc autoconf automake cmake cppcheck coreutils moreutils
                 zsh vim tmux subversion wget jupyter libomp)
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
# Load the zshrc file for better support
source ~/.zshrc

install_vim_package_manager

install_python_with_pyenv
