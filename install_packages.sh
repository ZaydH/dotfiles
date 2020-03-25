#!/usr/bin/env bash
source .functions

# Used to install homebrew on a mac
function install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    printf "Updating brew..."
    brew update > /dev/null
    printf "COMPLETED\n"
}

# OS Related constants for comparison
function install_and_update_package_manager() {
    if is_mac; then
        install_brew
    elif is_linux; then
        if is_debian; then
            sudo apt-get update > /dev/null
        elif is_manjaro; then
            sudo pacman -Syu > /dev/null
        else
            printf "Unknown Linux to update package manager...Exiting\n"
            exit 1
        fi
        printf "COMPLETED\n"
        # PKG_MNGR_INSTALL="sudo apt-get install -y"
    else
        printf "No supported package manager. Exiting..."
        exit 1
    fi
    # printf "Install command: ${PKG_MNGR_INSTALL}\n"
}

# Install package manager packages
function install_all_packages() {
    install_and_update_package_manager

    declare -a pkgs=(git git-lfs subversion hub tig
                     curl wget
                     gcc g++ autoconf automake cmake bison doxygen flex cppcheck
                     vim ctags exuberant-ctags
                     graphviz
                     gmp libgmp3-dev libgmp-dev
                     mpfr libmpfr-dev
                     mpc libmpc-dev
                     gzip bzip2 p7zip zlib1g-dev
                     fzf
                     reattach-to-user-namespace  # Used by tmux on MacOS for copying to clipboard
                     urlview  # Needed for tmux's urlview plugin
                     zsh-syntax-highlighting  # Needed for zsh plugin
                     fpp  # FaceBook path picker for tmux plugin
                     terminal-notifier  # MacOS only for setting notification
                     notify-send        # linux only
                     python python3 python-dev python3-dev python-devel ipython jupyter
                     pyenv-virtualenv  # Combines pyenv with virtualenv. May be brew specific
                     gnu-sed coreutils moreutils zsh tmux libomp libomp-dev
                     opendetex  # Tool for removing tex tags from a document
                     openssl libssl-dev readline readline-devel libreadline7
                     libreadline7-dev libreadline6-dev sqlite3 libsqlite3-dev
                     dkms build-essential)
    for pkg in ${pkgs[@]}; do
        install_cli_package ${pkg}
    done
    if is_mac; then
        # Remove outdated versions from the cellar.
        brew cleanup > /dev/null
    fi
}
