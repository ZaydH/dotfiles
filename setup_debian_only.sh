#!/usr/bin/env bash

# Vim in standard apt is out of date.  Gets the latest.
function _install_latest_vim() {
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install vim
    sudo add-apt-repository --remove ppa:jonathonf/vim
}

function _install_debian_conf() {
    install_cli_package dconf-editor
}

function setup_debian_only() {
    _install_latest_vim
    _install_debian_conf
}
