#!/usr/bin/env bash

# Installs one package via the package manager
function install_single_package() {
    printf "Installing package \"${1}\"..."
    cmd="${PKG_MNGR_INSTALL} ${1}"
    # printf "\n$cmd\n"
    eval $cmd > /dev/null
    printf "COMPLETED\n"
}

# Install package manager packages
function install_all_packages() {
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
                     python python3 python-dev python3-dev python-devel ipython jupyter
                     pyenv-virtualenv  # Combines pyenv with virtualenv. May be brew specific
                     coreutils moreutils zsh tmux libomp libomp-dev
                     openssl libssl-dev readline readline-devel libreadline7
                     libreadline7-dev libreadline6-dev sqlite3 libsqlite3-dev
                     dkms build-essential)
    for pkg in ${pkgs[@]}; do
        install_single_package ${pkg}
    done
    if [ ${OS} == ${MAC} ]; then
        installing_mactex
        # Remove outdated versions from the cellar.
        brew cleanup &> /dev/null
    fi
}
