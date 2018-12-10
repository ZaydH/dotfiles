set nocompatible              " be iMproved, required
filetype off                  " required

" =========================================================================
"     Vundle Start
" =========================================================================
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
" Fugitive vim git app
Plugin 'tpope/vim-fugitive'
" YouCompleteMe autocompletion support"
Plugin 'Valloric/YouCompleteMe'
" Gutentags
Plugin 'ludovicchabant/vim-gutentags'
" Install vim LaTeX suite
Plugin 'lervag/vimtex'
" Enable folding of blocks in LaTeX files
Plugin 'matze/vim-tex-fold'
" Nerdtree project folder viewer
Plugin 'scrooloose/nerdtree'
" Improved commenter
Plugin 'scrooloose/nerdcommenter'
" Python Mode
Plugin 'python-mode/python-mode'
" Python Docstring Generation
Plugin 'heavenshell/vim-pydocstring'
" Automatically import python modules
Plugin 'mgedmin/python-imports.vim'
" Integrate LLDB into vim
" Requires lldb be preinstalled on the system
Plugin 'gilligan/vim-lldb'
" Syntastic for syntax highlighting
Plugin 'vim-syntastic/syntastic'
" UltiSnips used for snippet expansion.
Plugin 'SirVer/ultisnips'
" gitgutter show the lines imodified in the file under use
Plugin 'airblade/vim-gitgutter'
" airline improved status bar
Plugin 'vim-airline/vim-airline'
" Needed for adding a color scheme to airline
Plugin 'vim-airline/vim-airline-themes'
" GruvBox color scheme
Plugin 'morhetz/gruvbox'

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
" =========================================================================
"     Vundle END
" =========================================================================

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

" Spell Check Settings ====================================================
" Use for US English
set spell spelllang=en_us
syntax on
" Disable spellcheck for vimrc
autocmd! bufreadpost .vimrc set nospell


" Basic vim and Shell Settings ============================================
" Reload vimrc after saving it
autocmd BufWritePost $MYVIMRC source $MYVIMRC
"" Use zsh as shell in vim so zshrc is available
"set shell=zsh\ --login

" Tab Settings ============================================================
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

" Python Plugins Information ==============================================
" Pylint configuration file
"let g:pymode_dlint_config = '$HOME/.pylintrc'

let g:pymode_python = 'python3'
let g:pymode_options_max_line_length = 100
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1

" Command to automatically add docstrings
" Uses plugin: vim-pydocstring
map """ <Plug>(pydocstring)
" Command to automatically import Python modules
" Uses plugin: python-imports.vim
map <C-o> :ImportName<CR>

" Syntastic ===============================================================
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

" NERDTree ================================================================
" Toggle NerdTree with nt
map nt :NERDTreeToggle<CR>
" Open NerdTree by default if nothing specified in vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

" YouCompleteMe ===========================================================
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

" UltiSnips ===============================================================
" Define where UltiSnips loops for snippets
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" SuperTab ================================================================
" Get back default behavior for tab to move the list down
let g:SuperTabDefaultCompletionType = "<c-n>"

" NERDCommenter ===========================================================
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
"Use // for comments in C"
let NERD_c_alt_style=1

" <leader> Key is Backslash \
" Source: https://stackoverflow.com/questions/1764263/what-is-the-leader-in-a-vimrc-file
" -------------------  Command Overview -----------------------------
" Source: https://github.com/scrooloose/nerdcommenter
"
" Comments the current line from the cursor to the end of line.
" <leader>cA |NERDComAppendComment|
" Comment out the current line or text selected in visual mode.
" [count]<leader>cn |NERDComNestedComment|
" Toggles the comment state of the selected line(s). If the topmost selected line is commented, all selected lines are uncommented and vice versa.
" [count]<leader>ci |NERDComInvertComment|
" Toggles the comment state of the selected line(s) individually. NEEDED IN PYTHON SINCE NO MULTILINE DELIMETER
" [count]<leader>cm |NERDComMinimalComment|
" Comments the given lines using only one set of multipart delimiters.

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" GruvBox =================================================================
" Find more information on settings here:
" https://github.com/morhetz/gruvbox/wiki/Terminal-specific
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

"==========================================================================
" vimtex Fix -- Must Be at the End of the File
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
