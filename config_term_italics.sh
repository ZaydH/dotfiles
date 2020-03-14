#!/usr/bin/env bash

# Based on: https://medium.com/@dubistkomisch/how-to-actually-get-italics-and-true-colour-to-work-in-iterm-tmux-vim-9ebe55ebc2be

TERM_DIR=terminal_info

tic -x ${TERM_DIR}/xterm-256color-italic.terminfo
tic -x ${TERM_DIR}/tmux-256color.terminfo
