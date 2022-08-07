#!/usr/bin/env bash
source .functions

function install_iterm2() {
    brew cask install iterm2
}

function install_mac_fonts() {
    # Install and Configure Fira Code Font
    brew tap homebrew/cask-fonts
    brew install --cask  font-fira-code
}

function run_mac_only_setup(){
    if ! is_mac; then
        printf "Running Mac-only installer on a system that appears to not be a mac...Exiting" >&2
        return 1
    fi
    install_iterm2

    install_mac_fonts

    source config_term_italics.sh
    configure_term_info
}
