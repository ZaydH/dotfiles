#!/usr/bin/env bash

function test_italics() {
    printf "If italics is working, the following should be italics...\n"
    echo -e "\e[3mI am italics.  If I am not italics, you have a problem\e[23m"
}

function configure_term_info(){
    # Based on: https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be
    TERM_DIR=terminal_info

    tic -x ${TERM_DIR}/xterm-256color-italic.terminfo
    tic -x ${TERM_DIR}/tmux-256color.terminfo
}
