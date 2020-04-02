#!/usr/bin/env bash

function make_gnome_look_like_mac() {
    source .functions
    # Packages needed for gnome like MacOS
    install_cli_package gnome-tweak-tool
    install_cli_package gtk2-engines-murrine
    install_cli_package gtk2-engines-pixbuf
}
