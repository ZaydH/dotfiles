set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" Supertab used for compatibility between YouCompleteMe and UltiSnips
" Needs to be first due to issue in supertab
Plugin 'ervandew/supertab'
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
" Gutentags
Plugin 'ludovicchabant/vim-gutentags'
" Install vim LaTeX suite
Plugin 'lervag/vimtex'
" Enable folding of blocks in LaTeX files
Plugin 'matze/vim-tex-fold'
" Improved commenter
Plugin 'scrooloose/nerdcommenter'
" Python Mode
Plugin 'python-mode/python-mode'
" Syntastic for syntax highlighting
Plugin 'vim-syntastic/syntastic'
" UltiSnips used for snippet expansion.
Plugin 'SirVer/ultisnips'

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

" Use for US English
set spell spelllang=en_us

" Display extra whitespace
set list listchars=tab:»·,trail:·,nbsp:·
" Use one space, not two, after punctuation.
set nojoinspaces
" Wrap text only on space
:set linebreak " "

" Enable copy and paste in vim
set clipboard=unnamed

" Enables text highlighting
filetype plugin on
syntax on

" Enables the backspace key to work
set backspace=indent,eol,start

" Uncomment the following to have Vim jump to the last position when reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g'\"" | endif
endif

set number          " Show line numbers
set numberwidth=5   " Set the maximum width of the number column on the left
set ruler           " Show the cursor position all the time
set laststatus=2    " Always display the status line
set hlsearch        " Highlight when searching.

" Used for ctags
set autochdir
set tags+=./tags;

" Configure tabs as spaces
set smartindent
set tabstop=4
set shiftwidth=4
set expandtab
:retab

" Create a specialized tab setting for C/C++/Tex
autocmd Filetype c++ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2

" REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
filetype plugin on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

"Use // for comments in C"
let NERD_c_alt_style=1

" Pylint configuration file
"let g:pymode_dlint_config = '$HOME/.pylintrc'

let g:pymode_python = 'python3'
let g:pymode_options_max_line_length = 100
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1

" Syntastic Default Settings
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" lacheck is for LaTeX
let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']

" Disable YouCompleteMe in these files
let g:ycm_filetype_blacklist = {
      \ 'tex': 1,
      \ 'bib': 1,
      \ 'markdown': 1,
      \}
" make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
"let g:SuperTabDefaultCompletionType = '<C-n>'
" Have enter select in YouCompleteMe
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" Define where UltiSnips loops for snippets
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" SuperTab Settings
" Get back default behavior for tab to move the list down
let g:SuperTabDefaultCompletionType = "<c-n>"

"==========================================================================
"==========================================================================
if exists("g:loaded_fix_indentkeys")
    finish
endif

let g:loaded_fix_indentkeys = 1

" Set indentkeys option again on changed filetype option.
" This fixes TeX \item indentation in combination with YouCompleteMe.
" See https://github.com/Valloric/YouCompleteMe/issues/1244
" You may add more filetypes if necessary.
autocmd FileType tex,plaintex execute "setlocal indentkeys=" . &indentkeys
