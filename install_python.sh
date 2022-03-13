#!/usr/bin/env bash

function install_pyenv() {
    source .zshrc > /dev/null
    if is_manjaro || is_mac; then
        install_cli_package pyenv
    elif is_debian; then
        curl https://pyenv.run | bash
    else
        printf "Unknown OS for pyenv install..." >&2
        return 1
    fi
    source .zshrc > /dev/null
}

# Installs linting tools
function install_python_linters() {
    source .functions
    task_msg="Installing python linting tools"
    printf "Starting: ${task_msg}...\n"
    install_cli_package "pylint"
    install_cli_package "flake8"
    install_cli_package "pep8"
    install_cli_package "pylama"
    printf "COMPLETED: ${task_msg}"
}


function install_3090_torch() {
    pip install torch==1.8.1+cu111 torchvision==0.9.1+cu111 torchaudio==0.8.1 \
        -f https://download.pytorch.org/whl/torch_stable.html
}

function install_python_with_pyenv() {
    install_pyenv

    printf "Updating PyEnv..."
    pyenv update > /dev/null
    printf "COMPLETED\n"

    install_python_linters()

    # Needed to ensure configuration is valid
    if is_mac; then
        export PYTHON_CONFIGURE_OPTS="--enable-framework"
    else
        # Needed to prevent error "python-build: framework installation is not supported."
        export PYTHON_CONFIGURE_OPTS=""
    fi

    # declare -a versions=("2.7.15" "3.6.5" "3.7.2")
    # declare -a versions=("3.6.5" "3.7.1" "3.8.1")
    declare -a versions=("3.7.1")
    for ver in "${versions[@]}"; do
        printf "Installing python version ${ver}..."
        pyenv install "${ver}" > /dev/null
        printf "COMPLETED\n"
        pyenv global "${ver}" > /dev/null
        install_python_packages
    done

    # if ! is_mac; then
    #     SYSTEM_INTERPRETER="system"
    #     printf "Processing ${SYSTEM_INTERPRETER} last...\n"
    #     pyenv global "${SYSTEM_INTERPRETER}" > /dev/null
    #     install_python_packages
    # fi

    printf "Enabling latest installed python version..."
    pyenv global "${versions[-1]}" > /dev/null
    printf "COMPLETED\n"

    install_3090_torch
}

# Standard function for install packages using pip
function install_python_packages() {
    # Ensure valid pip
    python -m pip install --upgrade --force-reinstall pip

    declare -a pip_pkgs=(cython  # Speeds up the debugger
                         setuptools  # Some packages rely on setup tools so update early
                         torch torchtext torchvision torchnet fastai==1.00.57 allennlp  # Neural network packages
                         pytorch-ignite  # NN package. May have a different name in conda
                         pytorch_influence_functions  # Implements implement function paper in torch
                         tensorflow keras tensorflow_probability
                         tensorboardX wandb
                         opencv-python  # OpenCV packages
                         comet_ml
                         statsmodels
                         pycm  # Confusion matrix package
                         cplex gurobipy # Linear system solvers
                         tflearn scikit-learn numpy scipy pillow pandas lightgbm matplotlib  # Machine learning packages
                         tsnecuda MulticoreTSNE  # t-SNE packages
                         gensim nltk fuzzywuzzy  # NLP packages
                         pywsl  # Python for Weakly Supervised Learning
                         densratio  # Used for density ratio estimation
                         virtualenv pipenv pipreqs  # Portability requirements
                         pytest tox   # Continuous integration and testing
                         requests ipython
                         jupyter jupytext jupyter_contrib_nbextensions notedown  # Jupyter notebook related packages
                         pylint flake8 pep8 pylama  # Generic python tools
                         exhale sphinx sphinx_rtd_theme yapf autopep8
                         pynvim  # Support for python and neovim
                         rope ropevim ropemode  # Rope for Python primarily
                         seaborn git-wrapper quilt dill lief tqdm futures
                         grip  # Used by vim's markdown preview package
                         fire  # Google Package for a simple command line interface
                         ruamel.yaml  # Improved yaml parser
                         pydot gmpy2  # Packages for WAPS
                         arxiv-collector # Used to prepare a tex document for Arxiv
                         mpi4py  # MPI package
                         )
    for pkg in ${pip_pkgs[@]}; do
        printf "Installing python package \"${pkg}\"..."
        pip install --upgrade ${pkg} > /dev/null
        printf "COMPLETED\n"
    done
}
