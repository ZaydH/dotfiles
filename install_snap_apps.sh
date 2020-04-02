#!/usr/bin/env bash

function _install_snap() {
    printf "Installing Snap App Store..."
    if is_debian; then
        sudo apt update &> /dev/null
        sudo apt install -y snapd &> /dev/null
    else
        printf "Unknown platform to install snap...Exiting" &>2
        return 1
    fi
    printf "COMPLETED\n"
}


function _install_snap_app_list() {
    declare -a SNAP_APPS=(
                          clion
                          code  # VSCode
                          pycharm-professional
                          signal-desktop
                          skype
                          slack
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