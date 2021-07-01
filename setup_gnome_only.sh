#!/usr/bin/env bash

function make_gnome_look_like_mac() {
    source .functions
    # Packages needed for gnome like MacOS
    install_cli_package gnome-tweak-tool
    install_cli_package gtk2-engines-murrine
    install_cli_package gtk2-engines-pixbuf
    install_cli_package libglib2.0-dev
}

function configure_gnome_terminal_colorscheme() {
    printf "Configuring gnome colorscheme...\n"

    source .functions
    # Packages needed by Gogh
    install_cli_package dconf-cli
    install_cli_package uuid-runtime

    # printf "Reset gnome legacy terminal profiles...\n"
    # dconf reset -f /org/gnome/terminal/legacy/profiles:/

    printf "Installing Gogh colorscheme tool...\n"
    bash -c  "$(wget -qO- https://git.io/vQgMr)"
}

function setup_ssh_server() {
    install_cli_package openssh-server
}

# Enables the gnome keyring to save the git credentials
function configure_git_for_gnome_keyring() {
    # install_cli_package libgnome-keyring-dev
    # GIT_KEYRING_DIR="/usr/share/doc/git/contrib/credential/gnome-keyring"
    # sudo make --directory="${GIT_KEYRING_DIR}"

    # CREDENTIAL_FILE="${GIT_KEYRING_DIR}/git-credential-gnome-keyring"
    # git config --global credential.helper "${CREDENTIAL_FILE}"

    # install_cli_package seahorse -y
    # install_cli_package git-credential-libsecret -y
    # git config — global credential.helper /usr/libexec/git-core/git-credential-libsecret
}

# function configure_libreoffice_packages() {
#     install_cli_package libreoffice-java-common
# }

function configure_appmenu_packages() {
    install_cli_package appmenu-gtk3-module
}

function set_gsettings_values() {
    gsettings set org.gnome.desktop.wm.preferences button-layout 'close,minimize,maximize:'
    gsettings set org.gnome.desktop.sound event-sounds false
}


# Encapsulates all the individual operations into a single function
function run_gnome_only_setup() {
    make_gnome_look_like_mac

    configure_gnome_terminal_colorscheme

    setup_ssh_server

    # configure_git_for_gnome_keyring

    configure_appmenu_packages

    set_gsettings_values

    # configure_libreoffice_packages
}
