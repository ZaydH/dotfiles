set nocompatible              " be iMproved, required


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
" Vim Comment tool
Plugin 'tpope/vim-commentary'
" Support basic Unix commands in vim
Plugin 'tpope/vim-eunuch'
" Surround selected text with paired brackets
Plugin 'tpope/vim-surround'
" Multiple cursors tool
Plugin 'terryma/vim-multiple-cursors'
" YouCompleteMe autocompletion support"
Plugin 'Valloric/YouCompleteMe'
" Enables quick traversal through a document
Plugin 'easymotion/vim-easymotion'
" Gutentags
Plugin 'ludovicchabant/vim-gutentags'
" Install vim LaTeX suite
Plugin 'lervag/vimtex'
" Command Line Fuzzy Finder for use with vimtex
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
" Fast Fold rather than automatic folding
Plugin 'Konfekt/FastFold'
" " Enable folding of blocks in LaTeX files
" Plugin 'matze/vim-tex-fold'
" Nerdtree project folder viewer
Plugin 'scrooloose/nerdtree'
" Python Mode
Plugin 'python-mode/python-mode'
" Pyrope for vim
Plugin 'python-rope/ropevim'
" Python Docstring Generation
Plugin 'heavenshell/vim-pydocstring'
" Automatically import python modules
Plugin 'mgedmin/python-imports.vim'
" " Syntastic for syntax highlighting
" Plugin 'vim-syntastic/syntastic'
" Improved syntax checking using Vim's asynchronous protocol
Plugin 'w0rp/ale'
" UltiSnips used for snippet expansion.
Plugin 'SirVer/ultisnips'
" gitgutter show the lines imodified in the file under use
Plugin 'airblade/vim-gitgutter'
" " airline improved status bar
Plugin 'vim-airline/vim-airline'
" " Needed for adding a color scheme to airline
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

" Display non-space whitespace
set list listchars=tab:»·,trail:·,nbsp:·
" Use one space, not two, after punctuation.
set nojoinspaces
" Wrap text only on space
:set linebreak " "
" Highlight the line when in insert mode
:autocmd InsertEnter,InsertLeave * set cul!

" Make search case insensitive by default.
:set ignorecase
:set smartcase

" turn hybrid (relative & absolute) line numbers on
:set number relativenumber
:set nu rnu

" Remap home to go to the tabbed beginning of the line
:map <Home> ^
:imap <Home> <Esc>^i

" Improve undo granularity
" Create new undo point after return (CR), space, or tab key pressed in insert mode
:inoremap <CR> <CR><C-g>u
:inoremap <Space> <Space><C-g>u
:inoremap <Tab> <Tab><C-g>u

" Regenerate the spelling file if out of date
for d in glob('~/.vim/spell/*.add', 1, 1)
    if filereadable(d) && (!filereadable(d . '.spl') || getftime(d) > getftime(d . '.spl'))
        silent exec 'mkspell! ' . fnameescape(d)
    endif
endfor

" Helper function to profile vim
function StartProfiling()
    profile start profile.log
    profile func *
    profile file *
endfunction


" Change the cursor shape in insert mode
" Other options (replace the number after \e[):
"   Ps = 0  -> blinking block.
"   Ps = 1  -> blinking block (default).
"   Ps = 2  -> steady block.
"   Ps = 3  -> blinking underline.
"   Ps = 4  -> steady underline.
"   Ps = 5  -> blinking bar (xterm).
"   Ps = 6  -> steady bar (xterm).
" Edit mode setting
"let &t_SI = "\e[6 q"
" Command mode setting
"let &t_EI = "\e[2 q"
" optional reset cursor on start:
"augroup myCmds
"au!
"autocmd VimEnter * silent !echo -ne "\e[2 q"
"augroup END

" Enable copy and paste in vim
set clipboard=unnamed

" Enables text highlighting
filetype plugin on
syntax on

" Enables the backspace key to work
set backspace=indent,eol,start

" Have Vim jump to the last position when reopening a file
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
" Create a specialized tab setting for C++
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
let g:pymode_lint_ignore = "E701,E704"

" Rope support
" call pymode#default('g:pymode_rope', 0)
call pymode#default('g:pymode_rope', 1)

" Command to automatically add docstrings
" Uses plugin: vim-pydocstring
map """ <Plug>(pydocstring)

" Command to automatically import Python modules
" Uses plugin: python-imports.vim
map <C-g> :ImportName<CR>
" let g:pymode_rope_autoimport=1
" let g:pymode_rope_autoimport_bind = '<C-c>ra'
" add the name of modules you want to autoimport
" let g:ropevim_autoimport_modules = ["os", "shutil", "sys", "datetime", "pickle", "math", "re", "warnings", "copy", "logging", "sklearn", "torch", "torchvision", "scipy"]

" Refactor a variable/function/class/method
let g:pymode_rope_rename_bind = '<F6>'

" " Syntastic ===============================================================
" " Syntastic Default Settings
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0

" " lacheck is for LaTeX
" let g:syntastic_tex_checkers = ['lacheck', 'text/language_check']

" " Use python3 for pyflakes
" " let g:syntastic_python_pyflakes_exe = 'python3 -m pyflakes'
" let g:syntastic_python_pyflakes_exe = ''

" ALE Settings ============================================================

" Keep the ALE gutter open at all times
let g:ale_sign_column_always = 1

" Fix Python files with autopep8 and yapf.
let b:ale_fixers = ['autopep8', 'yapf']

" Set this. Airline will handle the rest.
let g:airline#extensions#ale#enabled = 1

" NERDTree ================================================================

" Toggle NerdTree with nt
map nt :NERDTreeToggle<CR>

" Show hidden (e.g., dot files)
let NERDTreeShowHidden=1

" File extensions to exclude from displaying in NerdTree
let NERDTreeIgnore = [ '\.\(aux\|bbl\|blg\|fdb_latexmk\|fls\|gz\|log\|out\|pdf\|pyc\|swp\|toc\)$', ]

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
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" Have enter select in YouCompleteMe
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" UltiSnips ===============================================================
" Define where UltiSnips loops for snippets
let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" Parameters used by UltiSnips when generating commands
let g:ultisnips_python_quoting_style="double"
let g:ultisnips_python_triple_quoting_style="double"
let g:ultisnips_python_style='sphinx'

" SuperTab ================================================================
" Get back default behavior for tab to move the list down
let g:SuperTabDefaultCompletionType = "<C-n>"

" GruvBox =================================================================
" Find more information on settings here:
" https://github.com/morhetz/gruvbox/wiki/Terminal-specific
colorscheme gruvbox
set background=dark
let g:airline_theme='gruvbox'

" Change the color scheme for match parentheses to make it easier to view in
" latex
" hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
hi MatchParen cterm=bold ctermbg=gray

" EasyMotion =================================================================
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Turn on case insensitive feature
let g:EasyMotion_smartcase = 1

" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)

" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)

" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" FastFold ================================================================

let g:markdown_folding = 1
let g:tex_fold_enabled = 1
" Folds are updated whenever you close or open folds by a standard keystroke such as zx,zo or zc
let g:fastfold_fold_command_suffixes = []

" VimTex ==================================================================

" fzf used for navigation of table of contents
" \lt brings up navigation window
nnoremap <localleader>lt :call vimtex#fzf#run()<cr>

" Matching may become computationally intensive for complex LaTeX documents.
" If you experience slowdowns while moving the cursor, the following option
" is recommended to delay highlighting slightly while navigating: >
let g:matchup_matchparen_deferred = 1

let g:vimtex_fold_enabled = 0
" let g:vimtex_fold_manual = 1
" let g:vimtex_fold_enabled = 1

" Disable vimtex autocomplete in included lib files
let g:vimtex_include_search_enabled = 0

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
