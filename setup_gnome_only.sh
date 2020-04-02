#!/usr/bin/env bash

function make_gnome_look_like_mac() {
    source .functions
    # Packages needed for gnome like MacOS
    install_cli_package gnome-tweak-tool
    install_cli_package gtk2-engines-murrine
    install_cli_package gtk2-engines-pixbuf
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
