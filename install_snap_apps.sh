#!/usr/bin/env bash

function _install_snap() {
    if is_debian; then
        printf "Installing Snap App Store..."
        sudo apt update &> /dev/null
        sudo apt install -y snapd &> /dev/null
        printf "COMPLETED\n"
    elif is_mac; then
        install_cli_package snapcraft
    else
        printf "Unknown platform to install snap...Exiting" >&2
        return 1
    fi
}


function _install_snap_app_list() {
    declare -a SNAP_APPS=(
                          atom
                          clion
                          code  # VSCode
                          flameshot  # Alternative to Lightshot
                          pycharm-professional
                          signal-desktop
                          # skype
                          slack
                          # zoom-client
                         )
    for app_name in "${SNAP_APPS[@]}"; do
        printf "Install Snap app \"${app_name}\"..."
        sudo snap install --classic "${app_name}" > /dev/null
        printf "COMPLETED\n"
    done
}


function _install_snap_apps() {
    source .functions
    # Install snap app store
    _install_snap

    _install_snap_app_list

    printf "If installing on zsh, may need to modify zprofile to see snap apps.\n" >&2
    printf "For more information, see: https://askubuntu.com/questions/910821/programs-installed-via-snap-not-showing-up-in-launcher\n" >&2
    printf "Must log out for changes to take effect\n" >&2
}

_install_snap_apps
