#!/usr/bin/env bash

# Function for installing a file from then repository to the filesystem
function install_file() {
    ARG_FILE=`basename $1`
    ARG_PATH=`dirname $1`
    DEST_PATH=.${ARG_FILE}
    if [[ -z ${ARG_PATH} ]]; then
        DEST_PATH=${ARG_PATH}/${DEST_PATH}
    fi
    printf "Creating sylink for file: \"${DEST_PATH}\"\n"
    ln -sf $1 ~/${DEST_PATH}
}

install_file vimrc
install_file zshrc
