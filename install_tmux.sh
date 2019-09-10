OH_MY_TMUX_URL="https://github.com/gpakosz/.tmux"
OH_MY_TMUX_REPO_NAME=$( basename ${OH_MY_TMUX_URL} )
TMUX_CONF_LOCAL=".tmux.conf.local"

## tmux plugin manager must be manually installed
function install_tmux_plugin_manager() {
    printf "Installing tmux plugin manager..."
    PLUGIN_MANAGER_DIR="~/.tmux/plugins/tpm"
    if [ ! -d ${PLUGIN_MANAGER_DIR} ]; then
        git clone https://github.com/tmux-plugins/tpm ${PLUGIN_MANAGER_DIR} &> /dev/null
    fi
    # Pull directory to ensure plugin manager up to date
    git -C ${PLUGIN_MANAGER_DIR} pull &> /dev/null
    printf "COMPLETED\n"
}

function install_oh_my_tmux() {
    install_tmux_plugin_manager

    printf "Installing oh-my-tmux..."
    # Clone repo if does not exist
    if [ ! -d ${OH_MY_TMUX_REPO_NAME} ]; then
        git clone ${OH_MY_TMUX_URL} &> /dev/null
    fi
    # -C changes directory before pull
    git -C ${OH_MY_TMUX_REPO_NAME} pull &> /dev/null

    MY_TMUX_CONF=".tmux.conf.my"
    OH_MY_TMUX_LOCAL="${OH_MY_TMUX_REPO_NAME}/.tmux.conf.local"

    # Make a new .tmux.conf local file
    cat ${OH_MY_TMUX_LOCAL} ${MY_TMUX_CONF} > ${TMUX_CONF_LOCAL}
    printf "COMPLETED\n"
}
