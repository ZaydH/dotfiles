#!/usr/bin/env bash

TARGET_ANTIGEN=${HOME}/antigen.zsh

function install_oh_my_zsh() {
    printf "Copying ${TARGET_ANTIGEN}..."
    rm -rf ${TARGET_ANTIGEN} > /dev/null
    curl -L --silent --show-error git.io/antigen > ${TARGET_ANTIGEN}
    printf "COMPLETED\n"
}
