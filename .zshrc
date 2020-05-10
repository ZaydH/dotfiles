source ${HOME}/antigen.zsh

# Loads the specified dotfile if it exists
function load_dotfile() {
    DOT_PATH="${HOME}/$1"
    if [ -r "${DOT_PATH}" ]; then
        source "${DOT_PATH}"
    fi
}
load_dotfile .functions
if is_talapas; then
    load_dotfile .functions_talapas
fi

# Load the oh-my-zsh's library.
antigen use oh-my-zsh

# Bundles from the default repo (robbyrussell's oh-my-zsh).
antigen bundle git
# antigen bundle pip
antigen bundle command-not-found
antigen bundle python
antigen bundle tmux
if is_mac; then
    antigen bundle osx
fi

# Load the theme.
# antigen theme robbyrussell
antigen bundle mafredri/zsh-async
antigen bundle sindresorhus/pure

# Syntax highlighting bundle.
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting  # Must be the LAST plugin per github README

# Tell Antigen that you're done.
antigen apply


# Set list of themes to load
# Setting this variable when ZSH_THEME=random
# cause zsh load theme from this variable instead of
# looking in ~/.oh-my-zsh/themes/
# An empty array have no effect
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# # Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# # Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# # Example format: plugins=(rails git textmate ruby lighthouse)
# # Add wisely, as too many plugins slow down shell startup.
# plugins=(
#   git
#   python
#   tmux
#   osx
#   zsh-autosuggestions
#   zsh-syntax-highlighting
# )

if [ -d "${ZSH}" ]; then
    source $ZSH/oh-my-zsh.sh
    # Load oh-my-zsh autocompletion
    autoload -U compinit
    compinit
fi

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# Update the path environment variable
# export BISON_ROOT="/usr/local/opt/bison/bin"
# export PATH="$BISON_ROOT:$PATH"
#export FLEX_ROOT="/usr/local/opt/flex/bin"
#export PATH="$FLEX_ROOT:$PATH"
# export REFLEX_ROOT="${HOME}/reflex/bin"
# export PATH="$REFLEX_ROOT:$PATH"

# Print execution time if time exceeds below
PURE_CMD_MAX_EXEC_TIME=10 # s
# change the path color
# zstyle :prompt:pure:path color white
# # change the color for both `prompt:success` and `prompt:error`
# zstyle ':prompt:pure:prompt:*' color cyan
# turn on git stash status
zstyle :prompt:pure:git:stash show yes
# prompt pure

# Variables specifically for PyEnv
export PYENV_ROOT="${HOME}/.pyenv"
if [ -d ${PYENV_ROOT} ]; then
    export PATH="$PYENV_ROOT/bin:$PATH"
    if command -v pyenv 1>/dev/null 2>&1; then
      eval "$(pyenv init -)"
    fi
    eval "$(pyenv init -)"
fi


# # The next line updates PATH for the Google Cloud SDK.
# if [ -f "${HOME}/google-cloud-sdk/path.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/path.zsh.inc"; fi

# # The next line enables shell command completion for gcloud.
# if [ -f "${HOME}/google-cloud-sdk/completion.zsh.inc" ]; then . "${HOME}/google-cloud-sdk/completion.zsh.inc"; fi

# test if the prompt var is not set
if [ -z "$PS1" ]; then
    # prompt var is not set, so this is *not* an interactive shell
    return
fi

# If we reach this line of code, then the prompt var is set, so
# this is an interactive shell.
# Source commands only valid in interactive shells: https://unix.stackexchange.com/questions/154395/running-scp-when-bashrc-of-remote-machine-includes-source-command

load_dotfile .aliases

export EDITOR=$( which vim )

# Reorganize the $PATH variable so homebrew installs have higher priority
# over system software.  Examples where this has the most relevance
# is python and ruby.
#export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# # Load gruvbox color scheme
# if is_talapas; then
#     GRUV_BOX=${HOME}/.vim/bundle/gruvbox/gruvbox_256palette.sh
#     if [ -f "${GRUV_BOX}" ]; then
#         source "${GRUV_BOX}"
#     fi
# fi

# If  a  command is issued that can't be executed as a normal command,
# and the command is the name of a directory, perform the cd command
# to that directory.
setopt autocd

# File extensions to ignore when autocompleting in zsh
## With vim, ignore .(*******) files
VIM_IGNORE_EXT="aux|bbl|blg|fdb*|fls|gz|log|nav|out|pdf|pyc|pyo|snm|synctex\(busy\)|toc"
zstyle ':completion:*:*:vim:*' file-patterns '^*.(${VIM_IGNORE_EXT}):source-files' '*:all-files'
