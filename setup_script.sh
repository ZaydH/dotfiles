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
    # Install zsh-autosuggestions
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
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
# Install mactex - TeX distribution for MacOS
function installing_mactex() {
    printf "Installing mactex - this may take a while..."
    brew tap caskroom/cask > /dev/null
    brew cask install mactex > /dev/null
    printf "COMPLETED"
}

function install_google_sdk() {
    if [ ${OS} == ${MAC} ]; then
        curl https://sdk.cloud.google.com | bash
        exec -l $SHELL
    else
        # Create environment variable for correct distribution
        export CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"

        # Add the Cloud SDK distribution URI as a package source
        echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list

        # Import the Google Cloud Platform public key
        curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -

        # Update the package list and install the Cloud SDK
        GOOG_SDK_PKG=google-cloud-sdk
        cmd="${PKG_MNGR_INSTALL} ${GOOG_SDK_PKG}"
        eval $cmd > /dev/null
    fi
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
    # Link dotfiles
    DOTFILES_REPO=dotfiles
    mkdir -p ${REPOS_DIR} &> /dev/null
    cd $REPOS_DIR
    printf "Cloning the ${DOTFILES_REPO} repo..."
    rm -rf ${DOTFILES_REPO} > /dev/null
    git clone ${GITHUB_BASE}${DOTFILES_REPO} > /dev/null
    printf "COMPLETED\n"

    cd - > /dev/null
    cd ${REPOS_DIR}${DOTFILES_REPO} > /dev/null
    LINK_FILES_SCRIPT="./line_files.sh"
    chmod +x ${LINK_FILES_SCRIPT}
    printf "Linking the dot files..."
    eval ${LINK_FILES_SCRIPT} > /dev/null
    printf "COMPLETED\n"
    # Return to previous directory
    cd -
    # Load the zshrc file for better support
    source ~/.zshrc
}

# Enable Jupyter Extensions
function install_jupyter_extensions() {
    ./install_jupyter_extensions.sh
}

determine_os

# install_and_update_package_manager
# source install_packages.sh
# install_all_packages

source install_tmux.sh
install_oh_my_tmux

# setup_dot_files

# install_python_with_pyenv

# install_vim_package_manager

# install_jupyter_extensions

#=====================================================
# Do last to prevent conflicts between shells
#=====================================================
# install_ohmyzsh
