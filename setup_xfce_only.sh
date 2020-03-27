#~/usr/bin/env bash
XFCE_DIR=xfce4

function add_xfce_colorschemes() {
    COLORSCHEME_DIR="terminal/colorschemes"
    THEME_PATH=$(pwd)/"${XFCE_DIR}/${COLORSCHEME_DIR}"

    XFCE_SHARE_COLORSCHEMES_DIR="${HOME}/.local/share/xfce4/terminal/colorschemes"

    printf "ln -s ${THEME_PATH}/*.theme \"${XFCE_SHARE_COLORSCHEMES_DIR}/\"\n"
    ln -s ${THEME_PATH}/*.theme "${XFCE_SHARE_COLORSCHEMES_DIR}/"
}

function run_xfce_setup() {
    add_xfce_colorschemes
}

run_xfce_setup
