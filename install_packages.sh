#!/usr/bin/env bash
source .functions

# Used to install homebrew on a mac
function install_brew() {
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" > /dev/null
    brew update > /dev/null
}

# OS Related constants for comparison
function install_and_update_package_manager() {
    printf "Installing and updating package manager..."
    if is_mac; then
        install_brew
    elif is_linux; then
        if is_debian; then
            sudo apt-get update > /dev/null
        elif is_fedora; then
            sudo yum update > /dev/null
        elif is_manjaro; then
            sudo pacman -Syu > /dev/null
        else
            printf "ERROR: Unknown Linux to update package manager. Exiting...\n" >&2
            return 1
        fi
    else
        printf "ERROR: No supported package manager. Exiting...\n" >&2
        return 1
    fi
    printf "COMPLETED\n"
}

function cleanup_package_manager() {
    printf "Cleaning up unneeded packages..."
    if is_mac; then
        # Remove outdated versions from the cellar.
        brew cleanup > /dev/null
    elif is_debian; then
        sudo apt-get autoremove > /dev/null
        sudo apt-get clean > /dev/null
    elif is_fedora; then
        sudo yum autoremove > /dev/null
        sudo yum clean > /dev/null
    elif is_manjaro; then
        sudo pacman -Qet > /dev/null
    fi
    printf "COMPLETED\n"
}

# Single argument is a list of packages.  This function installs all of those packages.
function install_package_array() {
    pkgs=$1
    for pkg in ${pkgs[@]}; do
        install_cli_package ${pkg}
    done
}

# Install package manager packages
function install_all_packages() {
    install_and_update_package_manager

    declare -a GENERAL_PKGS=(git git-lfs subversion hub tig
                             curl wget
                             zsh tmux  # Shell packages
                             gcc g++ autoconf automake cmake bison doxygen flex cppcheck
                             vim ctags exuberant-ctags  # vim specific packages
                             graphviz
                             gmp libgmp3-dev libgmp-dev
                             mpfr libmpfr-dev
                             mpc libmpc-dev
                             gzip bzip2 p7zip zlib1g-dev  # Compressed file tools
                             fzf
                             urlview  # Needed for tmux's urlview plugin
                             zsh-syntax-highlighting  # Needed for zsh plugin
                             fpp  # FaceBook path picker for tmux plugin
                             python python3 python-dev python3-dev python-devel ipython jupyter
                             pyenv-virtualenv  # Combines pyenv with virtualenv. May be brew specific
                             coreutils moreutils libomp libomp-dev
                             opendetex  # Tool for removing tex tags from a document
                             openssl libssl-dev readline readline-devel libreadline7
                             libreadline7-dev libreadline6-dev sqlite3 libsqlite3-dev
                             dkms build-essential
                            )
    declare -a LINUX_ONLY_PKGS=(plank  # Desktop bar
                                notify-send  # Notification generator
                                xsel   # Needed by tmux-yank package
                               )
    declare -a MANJARO_ONLY_PKGS=(atom
                                 )
    declare -a MAC_ONLY_PKGS=(gnu-sed  # Optionally allow "gsed" on Mac to get GNU-standard sed
                              terminal-notifier  # MacOS only for setting notification
                              reattach-to-user-namespace  # Used by tmux on MacOS for copying to clipboard
                             )

    install_package_array ${GENERAL_PKGS}
    if is_linux; then
        install_package_array ${LINUX_ONLY_PKGS}
    do
    if is_manjaro; then
        install_package_array ${MANJARO_ONLY_PKGS}
    do
    if is_mac; then
        install_package_array ${MAC_ONLY_PKGS}
    do

    cleanup_package_manager
}
