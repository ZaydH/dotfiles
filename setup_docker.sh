#!/usr/bin/env bash

# Post install instructions based on:
#   https://docs.docker.com/engine/install/linux-postinstall/

function install_docker_packages() {
    declare -a DOCKER_PKGS=(
                            docker
                            docker.io  # Docker packages
                           )

    for pkg in ${DOCKER_PKGS[@]}; do
        install_cli_package ${pkg}
    done
}


function setup_group_privileges() {
    # Create the docker group.
    sudo groupadd docker
    # Add your user to the docker group.
    sudo usermod -aG docker $USER

    printf "ALERT: You need to log out and log back in then run \"newgrp docker\"\n"
    newgrp docker
}


function enable_docker_on_boot() {
    sudo systemctl enable docker.service
    sudo systemctl enable containerd.service
}


function disable_docker_on_boot() {
    sudo systemctl disable docker.service
    sudo systemctl disable containerd.service
}


function install_docker() {
    source "${HOME}/.functions"

    install_docker_packages
    setup_group_privileges

    enable_docker_on_boot
}
