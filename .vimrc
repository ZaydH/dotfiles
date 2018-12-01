set spelllang=en_us           " Use US English

set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
"Plugin 'file:///home/gmarik/path/to/plugin'"

" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the runtimepath properly.
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" YouCompleteMe autocompletion support"
Plugin 'Valloric/YouCompleteMe'
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


" Enable copy and paste in vim
set clipboard=unnamed

" Enables text highlighting
filetype plugin on
syntax on

" Enables the backspace key to work
set backspace=indent,eol,start

" Show line numbers
set number

" Highlight when searching."
set hlsearch

" Configure tabls as spaces
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
:retab

" Python mode support. 
" References the github repo: github.com/python-mode/python-mode
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdcommenter'
" References the github repo: github.com/python-mode/python-mode
Plug 'python-mode/python-mode', { 'branch': 'develop' }

call plug#end()

"Use // for comments in C"
let NERD_c_alt_style=1

" Pylint configuration file
"let g:pymode_dlint_config = '$HOME/.pylintrc'

let g:pymode_python = 'python3'
let g:pymode_options_max_line_length = 100
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1

