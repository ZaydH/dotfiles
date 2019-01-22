#!/usr/bin/env bash

GITHUB_BASE=https://github.com/ZaydH/
REPOS_DIR=~/repos/

# OS Related constants for comparison
MAC=Mac
LINUX=Linux

OS=ERROR # Define later
PKG_MNGR_INSTALL=ERROR # Defined later

function determine_os() {
    UNKNOWN="Unknown"
    case "$OSTYPE" in
      # solaris*) echo "SOLARIS" ;;
      darwin*)  OS=${MAC} ;;
      linux*)   OS=${LINUX} ;;
      # bsd*)     echo "BSD" ;;
      # msys*)    echo "WINDOWS" ;;
      *)        OS=${UNKNOWN} ;;
    esac

    if [ $OS == $UNKNOWN ]; then
        printf "Unknown/unsupported OS detected. Exiting...\n"
        exit 1
    fi
    printf "OS Detected: ${OS}\n"
}

function install_ohmyzsh() {
    printf "Installing Oh My ZSH..."
    rm -rf ~/.oh-my-zsh &> /dev/null
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null
    printf "COMPLETED\n"
    setup_dot_files
}

function install_and_update_package_manager() {
    if [ ${OS} == ${MAC} ]; then
        install_brew
        PKG_MNGR_INSTALL="brew install"
    elif [ ${OS} == ${LINUX} ]; then
	printf "Updating package manager..."
	sudo apt-get update &> /dev/null
	printf "COMPLETED\n"
        PKG_MNGR_INSTALL="sudo apt-get install -y"
    else
        printf "No supported package manager. Exiting..."
        exit 1
    fi
    # printf "Install command: ${PKG_MNGR_INSTALL}\n"
}

# Used to install homebrew on a mac
function install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    printf "Updating brew..."
    brew update &> /dev/null
    printf "COMPLETED\n"
}

# Install package manager packages
function install_all_packages() {
    declare -a pkgs=(gmp libgmp3-dev git git-lfs bison gzip gcc g++ autoconf automake cmake
                     cppcheck coreutils moreutils zsh vim tmux subversion wget jupyter libomp libomp-dev
                     zlib1g-dev openssl libssl-dev bzip2 readline readline-devel libreadline7
                     libreadline7-dev libreadline6-dev sqlite3 libsqlite3-dev curl python python3
                     python-dev python3-dev python-devel dkms build-essential ctags exuberant-ctags)
    for pkg in ${pkgs[@]}; do
        install_single_package ${pkg}
    done
}

# Installs one package via the package manager
function install_single_package() {
    printf "Installing package \"${1}\"..."
    cmd="${PKG_MNGR_INSTALL} ${1}"
    # printf "\n$cmd\n"
    eval $cmd > /dev/null
    printf "COMPLETED\n"
}

# Installing the vim package manager vundle
function install_vim_package_manager() {
    VIM_BUNDLE_FOLDER=~/.vim/bundle/
    printf "Installing vim package manager \"vundle\"..."
    rm -rf ${VIM_BUNDLE_FOLDER} &> /dev/null
    git clone https://github.com/VundleVim/Vundle.vim.git ${VIM_BUNDLE_FOLDER}Vundle.vim &> /dev/null
    printf "COMPLETED\n"
    printf "Installing vim plugins..."
    vim -c 'PluginInstall' -c 'qa!' # &> /dev/null
    printf "COMPLETED\n"

    YCM=YouCompleteMe
    printf "Installing ${YCM}..."
    cd ${VIM_BUNDLE_FOLDER}${YCM}
    python install.py > /dev/null
    cd -
    printf "COMPLETED\n"
}

function install_python_with_pyenv() {
    printf "Installing PyEnv..."
    source ~/.zshrc &> /dev/null
    if [ ${OS} == ${MAC} ]; then
        brew install pyenv > /dev/null
    else
        curl -s https://pyenv.run 2> /dev/null | bash > /dev/null
    fi
    printf "COMPLETED\n"

    printf "Updating PyEnv..."
    pyenv update &> /dev/null
    printf "COMPLETED\n"

    # Needed to ensure configuration is valid
    export PYTHON_CONFIGURE_OPTS="--enable-shared"
    declare -a versions=("2.7.15" "3.6.5" "3.7.1")
    for ver in ${versions[@]}; do
        printf "Installing python version ${ver}..."
        cmd="pyenv install ${ver}"
        eval ${cmd} &> /dev/null
        printf "COMPLETED\n"
        pyenv global ${ver}
        printf "Upgrading pip..."
        pip install --upgrade pip &> /dev/null
        printf "COMPLETED\n"
        install_python_packages
    done
}

function setup_dot_files() {
    # Link dotfiles
    DOTFILES_REPO=dotfiles
    mkdir -p ${REPOS_DIR} &> /dev/null
    cd $REPOS_DIR
    printf "Cloning the ${DOTFILES_REPO} repo..."
    rm -rf ${DOTFILES_REPO} > /dev/null
    git clone ${GITHUB_BASE}${DOTFILES_REPO} > /dev/null
    printf "COMPLETED\n"

    cd - &> /dev/null
    cd ${REPOS_DIR}${DOTFILES_REPO} > /dev/null
    INSTALL_SCRIPT="./install_files.sh"
    chmod +x ${INSTALL_SCRIPT}
    printf "Installing the dot files..."
    eval ${INSTALL_SCRIPT} &> /dev/null
    printf "COMPLETED\n"
    # Return to previous directory
    cd -
    # Load the zshrc file for better support
    source ~/.zshrc
}
# Standard function for install packages using pip
function install_python_packages() {
    declare -a pip_pkgs=(torch torchtext torchvision torchnet tensorflow tflearn sklearn numpy
                         scipy pillow ipython pandas git-wrapper quilt dill matplotlib
                         exhale sphinx exhale sphinx_rtd_theme lightgbm seaborn jupyter
                         fuzzywuzzy keras)
    for pkg in ${pip_pkgs[@]}; do
        printf "Installing python package \"${pkg}\"..."
        pip install ${pkg} > /dev/null
        printf "COMPLETED\n"
   done
}

determine_os

install_and_update_package_manager
install_all_packages

# setup_dot_files

# install_python_with_pyenv

# install_vim_package_manager

#=====================================================
# Do last to prevent conflicts between shells
#=====================================================
# install_ohmyzsh
