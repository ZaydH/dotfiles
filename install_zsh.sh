function install_single_zsh_plugin() {
    REPO_URL_SUFFIX=$1
    REPO_NAME=$( basename ${REPO_URL_SUFFIX} )
    REPO_DIR="${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/${REPO_NAME}"

    printf "Installing plugin \"${REPO_NAME}\"..."

    # If repo does not exist, clone.  Then pull
    if [ ! -d ${REPO_DIR} ]; then
        git clone https://github.com/${REPO_URL_SUFFIX} ${REPO_DIR} &> /dev/null
    fi
    git -C ${REPO_DIR} pull &> /dev/null
    printf "COMPLETED\n"
}


function install_all_zsh_plugins() {
    install_single_zsh_plugin "zsh-users/zsh-autosuggestions"
    install_single_zsh_plugin "zsh-users/zsh-syntax-highlighting"
}


function install_oh_my_zsh() {
    printf "Installing Oh My ZSH..."
    rm -rf ~/.oh-my-zsh &> /dev/null
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &> /dev/null
    printf "COMPLETED\n"
}


