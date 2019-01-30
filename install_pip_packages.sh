#!/usr/bin/env bash

# Standard function for install packages using pip
function install_python_packages() {
    declare -a pip_pkgs=(pip  # Always upgrade pip first
                         fastai torch torchtext torchvision tensorboardX torchnet tensorflow keras  # Neural network packages
                         tflearn sklearn numpy scipy pillow pandas lightgbm matplotlib  # Machine learning packages
                         ipython jupyter jupytext pylint  # Generic python tools
                         exhale sphinx sphinx_rtd_theme seaborn git-wrapper quilt dill lief
                         fuzzywuzzy)
    for pkg in ${pip_pkgs[@]}; do
        printf "Installing python package \"${pkg}\"..."
        pip install --upgrade ${pkg} > /dev/null
        printf "COMPLETED\n"
   done
}

# pip install --upgrade pip &> /dev/null
install_python_packages
