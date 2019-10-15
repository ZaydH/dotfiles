#!/usr/bin/env bash

# Standard function for install packages using pip
function install_python_packages() {
    declare -a pip_pkgs=(pip  # Always upgrade pip first
                         torch torchtext torchvision torchnet fastai  # Neural network packages
                         pytorch-ignite  # NN package. May have a different name in conda
                         tensorboardX tensorflow keras chainer  # Non-PyTorch neural net packages
                         cplex gurobi # Linear system solvers
                         tflearn scikit-learn numpy scipy pillow pandas lightgbm matplotlib  # Machine learning packages
                         gensim nltk fuzzywuzzy  # NLP packages
                         pywsl  # Python for Weakly Supervised Learning
                         virtualenv pipenv pipreqs  # Portability requirements
                         pytest tox   # Continuous integration and testing
                         requests ipython jupyter jupytext pylint # Generic python tools
                         exhale sphinx sphinx_rtd_theme yapf autopep8 rope
                         seaborn git-wrapper quilt dill lief tqdm futures
                         fire  # Google Package for a simple command line interface
                         pydot gmpy2  # Packages for WAPS
                         )
    for pkg in ${pip_pkgs[@]}; do
        printf "Installing python package \"${pkg}\"..."
        pip install --upgrade ${pkg} > /dev/null
        printf "COMPLETED\n"
   done
}

# pip install --upgrade pip &> /dev/null
install_python_packages
