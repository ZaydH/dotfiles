#!/usr/bin/env bash

# Vim in standard apt is out of date.  Gets the latest.
function install_latest_vim() {
    sudo add-apt-repository ppa:jonathonf/vim
    sudo apt update
    sudo apt install vim
    sudo add-apt-repository --remove ppa:jonathonf/vim
}
