#!/usr/bin/env bash

TARGET_ANTIGEN=${HOME}/antigen.zsh

function install_oh_my_zsh() {
    chsh -s $(which zsh)
    printf "Changed default terminal to zsh...May require a restart before setting applied.\n"

    printf "Copying ${TARGET_ANTIGEN}..."
    rm -rf ${TARGET_ANTIGEN} > /dev/null
    curl -L --silent --show-error git.io/antigen > ${TARGET_ANTIGEN}
    printf "COMPLETED\n"
}
