#!/usr/bin/env bash

function install_jupyter_vim_binding() {
    # You may need the following to create the directory
    mkdir -p $(jupyter --data-dir)/nbextensions
    # Now clone the repository
    cd $(jupyter --data-dir)/nbextensions
    git clone https://github.com/lambdalisue/jupyter-vim-binding vim_binding

    # Enable the vim bindings
    jupyter nbextension enable vim_binding/vim_binding
}

# Enable Jupyter extensions
jupyter nbextensions_configurator enable --user

install_jupyter_vim_binding
