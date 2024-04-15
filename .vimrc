set nocompatible              " be iMproved, required

" =========================================================================
"     vim-plug Start
" =========================================================================

" Autoinstall vim-plug if it doesn't exist
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin()

" Supertab used for compatibility between CoC and UltiSnips
" Needs to be first due to issue in supertab
Plug 'ervandew/supertab'
" " Improved syntax checking using Vim's asynchronous protocol
" Plug 'w0rp/ale'

" UI {{{
" Plug 'wellle/context.vim'                   | " Display context (e.g., class, function, if, loop, etc.)
Plug 'Konfekt/FastFold'                     | " Fast Fold rather than automatic folding
" Plug 'scrooloose/nerdtree'                  | " File explorer
" TODO remove after bug in ideavim fixed that allows pipe on plug line
Plug 'scrooloose/nerdtree'
Plug 'vim-airline/vim-airline'              | " Bottom bar
" }}} UI

" Motion {{{
Plug 'pechorin/any-jump.vim'                | " IDE like navigation
Plug 'easymotion/vim-easymotion'            | " Enables quick traversal through a document
" }}} Motion

" Git {{{
Plug 'tpope/vim-fugitive'                   | " Git tools
Plug 'rbong/vim-flog'                       | " Commit graph viewer.  Use command :Flog
Plug 'airblade/vim-gitgutter'               | " Show git status in right margin
Plug 'rhysd/git-messenger.vim'              | " Show git message on line. Use either :GitMessenger or <Leader>gm
" }}} Git

" Auto-complete and Snippets {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Shougo/neco-vim'
Plug 'Shougo/neoinclude.vim'
Plug 'neoclide/coc-neco'
Plug 'jsfaint/coc-neoinclude'
Plug 'SirVer/ultisnips'
" }}} Auto-complete and Snippets

" Tex {{{
Plug 'lervag/vimtex'
Plug 'junegunn/fzf'                         | " Command Line Fuzzy Finder for use with vimtex
Plug 'junegunn/fzf.vim'
Plug 'reedes/vim-wordy'                     | " Wordy detects poor uses of language
" }}} Tex

" TODO remove after bug in ideavim does not misread package name
" Language Support aug {{{
Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }   | " Python mode
Plug 'vhdirk/vim-cmake'                     | " Integrate CMake
Plug 'pboettch/vim-cmake-syntax'            | " Better highlighting of cmake files
Plug 'kevinoid/vim-jsonc'                   | " Syntax highlighting for jsonc -- JSON with comments
Plug 'ekalinin/dockerfile.vim'              | " Dockerfile syntax highlighting
" If you don't have nodejs and yarn
" use pre build, add 'vim-plug' to the filetype list so vim-plug can update this plugin
" see: https://github.com/iamcco/markdown-preview.nvim/issues/50
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'hashivim/vim-terraform'               | " Terraform language
" TODO remove after bug in ideavim does not misread package name
" }}} Langauge Support aug

" Color Schemes {{{
Plug 'morhetz/gruvbox'                      | " GruvBox
Plug 'danilo-augusto/vim-afterglow'         | " Afterglow
"aug END TODO remove after bug in ideavim does not misread package name
" }}} Color Schemes

" Tools {{{
Plug 'luochen1990/rainbow'                  | " Rainbow parentheses - not compatible with vimtex
Plug 'godlygeek/tabular'                    | " Tabular enables easy alignment of text
" Plug 'python-rope/ropevim'                  | " Pyrope for vim
" " if $HOSTNAME !~ "talapas-[a-z0-9]\*" && $HOSTNAME !~ "n[0-9]\+"
" if $HOSTNAME !~ '\(talapas-ln[1-2]*\|n[0-9]\+\)'
"     Plug 'szymonmaszke/vimpyter'            | " Jupyter Notebook support in vim
" endif
Plug 'preservim/tagbar'                     | " View the tags in the program
" Plug 'tpope/vim-commentary'                 | " Commenting tools
" TODO remove after bug in ideavim fixed that allows pipe on plug line
Plug 'tpope/vim-commentary'
Plug 'romainl/vim-cool'                     | " Automatically disable highlighting after search
Plug 'tpope/vim-eunuch'                     | " Support basic Unix commands in vim
" TODO remove after bug in ideavim fixed that allows pipe on plug line
" Plug 'machakann/vim-highlightedyank'        | " Highlight the yanked region
Plug 'machakann/vim-highlightedyank'
Plug 'RRethy/vim-illuminate'                | " Highlight other uses of the word
Plug 'terryma/vim-multiple-cursors'         | " Multiple cursors tool
Plug 'tpope/vim-speeddating'                | " Tools for working with dates
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'                     | " Enable dot repeat commands for vim-surround and other plugins
Plug 'sakshamgupta05/vim-todo-highlight'    | " ToDo highlighting
Plug 'tmux-plugins/vim-tmux'                | " Enables proper highlighting and documentation linking for .tmux.conf in vim
if v:version >= 800                         | " Gutentags
    Plug 'ludovicchabant/vim-gutentags'
    Plug 'skywind3000/gutentags_plus'
endif
" }}} Tools

" Miscellaneous {{{
Plug 'itchyny/calendar.vim'                 | " Simple calendar. Access via :Calendar
Plug 'mbbill/undotree'                      | " See vim undo tree.  Access via :UndotreeToggle
" }}} Miscellaneous

" All of your Plugins must be added before the following line
call plug#end()
filetype plugin indent on    " required

" =========================================================================
"     vim-plug END
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
" Override the 0 key to go to the tabbed beginning of the line not the
" absolute beginning
:nnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
:xnoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'
:onoremap <expr> 0 virtcol('.') == indent('.')+1 ? '0' : '^'vnoremap 00 0

" " Map F12 to disable highlighting
" :map <F11> :noh<CR>

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
if has("unix")
    set clipboard=unnamedplus
else
    set clipboard=unnamed
endif

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
set incsearch       " Moves highlight as types

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
map <leader>vimrc :tabe $MYVIMRC<cr>
autocmd bufwritepost .vimrc source $MYVIMRC
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

" " REQUIRED. This makes vim invoke Latex-Suite when you open a tex file.
" filetype plugin on
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
let g:tex_flavor='latex'

" Remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e

" Python Plugins Information ==============================================
" Pylint configuration file
" pymode_dlint_config = '$HOME/.pylintrc'

" Detect the python version automatically to prevent issues on Talapas
if has("python3")
    let g:pymode_python = 'python3'
else
    let g:pymode_python = 'python'
endif
let g:pymode_options_max_line_length = 100
let g:pymode_lint_options_pep8 = {'max_line_length': g:pymode_options_max_line_length}
let g:pymode_options_colorcolumn = 1
let g:pymode_lint_ignore = "E701,E704"

" Rope support
" call pymode#default('g:pymode_rope', 0)
" call pymode#default('g:pymode_rope', 1)

" " Command to automatically add docstrings
" " Uses plugin: vim-pydocstring
" map """ <Plug>(pydocstring)

" Command to automatically import Python modules
" Uses plugin: python-imports.vim
map <C-g> :ImportName<CR>
" let g:pymode_rope_autoimport=1
" let g:pymode_rope_autoimport_bind = '<C-c>ra'
" add the name of modules you want to autoimport
" let g:ropevim_autoimport_modules = ["os", "shutil", "sys", "datetime", "pickle", "math", "re", "warnings", "copy", "logging", "sklearn", "torch", "torchvision", "scipy"]

let g:pymode_rope_goto_definition_bind = '<C-c>g'
" Command for open window when definition has been found
" Values are (`e`, `new`, `vnew`)
let g:pymode_rope_goto_definition_cmd = 'new'

" Refactor a variable/function/class/method
let g:pymode_rope_rename_bind = '<F6>'

let g:pymode_folding = 1

" rainbow ===============================================================

let g:rainbow_active = 1 " set to 0 if you want to enable it later via :RainbowToggle

" vim-illuminate  ===============================================================

" Time in milliseconds (default 250)
let g:Illuminate_delay = 500

let g:Illuminate_ftblacklist = [
      \ 'markdown',
      \ 'wiki',
      \]

" NERDTree ================================================================

" Toggle NerdTree with nt
map nt :NERDTreeToggle<CR>

" Show hidden (e.g., dot files)
let NERDTreeShowHidden=1

" File extensions to exclude from displaying in NerdTree
let NERDTreeIgnore = [ '\.\(aux\|auxlock\|bbl\|bcf\|blg\|dep\|dpth\|fdb_latexmk\|fls\|gz\|log\|md5\|nav\|out\|pdf\|pyc\|run.xml\|snm\|synctex*\|swp\|toc\)$', ]

" Open NerdTree by default if nothing specified in vim.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

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

" Color Scheme =================================================================

" " Find more information on settings here:
" " https://github.com/morhetz/gruvbox/wiki/Terminal-specific
" colorscheme gruvbox
" set background=dark
" let g:airline_theme='gruvbox'

silent! colorscheme afterglow
" let g:airline_theme='afterglow'

" Change the color scheme for match parentheses to make it easier to view in latex
" hi MatchParen cterm=bold ctermbg=none ctermfg=magenta
hi MatchParen cterm=bold ctermbg=gray

" Underline misspelled words
hi clear SpellBad
hi SpellBad cterm=underline
" Set style for gVim
hi SpellBad gui=undercurl

" Fixes strange cyan highlighting of non-local terms.
" More details, see: https://vi.stackexchange.com/questions/14686/what-is-the-difference-between-red-and-cyan-in-spell-check-highlighting/14687
hi SpellLocal cterm=underline ctermbg=8 gui=undercurl guisp=DarkGray

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

" FastFold =============================================================

let g:markdown_folding = 1
let g:tex_fold_enabled = 1
" Folds are updated whenever you close or open folds by a standard keystroke such as zx,zo or zc
let g:fastfold_fold_command_suffixes = []

" any-jump =============================================================

" Background color
hi Pmenu guibg=#1b1b1b ctermbg=Black

let g:any_jump_colors = {
      \"plain_text":         "Comment",
      \"preview":            "Comment",
      \"preview_keyword":    "Operator",
      \"heading_text":       "Function",
      \"heading_keyword":    "Identifier",
      \"group_text":         "Comment",
      \"group_name":         "Function",
      \"more_button":        "Operator",
      \"more_explain":       "Comment",
      \"result_line_number": "Comment",
      \"result_text":        "Statement",
      \"result_path":        "String",
      \"help":               "Comment"
      \}

" COC ==================================================================

" See also: coc-settings.json

let g:coc_global_extensions = [
      \ 'coc-git',
      \ 'coc-json',
      \ 'coc-omni',
      \ 'coc-python',
      \ 'coc-pyright',
      \ 'coc-ultisnips',
      \ 'coc-vimlsp',
      \ 'coc-vimtex',
      \ 'coc-yaml',
      \]

" Make CoC work with tab
let g:SuperTabDefaultCompletionType = "<c-n>"

inoremap <silent><expr> <c-space> coc#refresh()

inoremap <expr><cr>    pumvisible() ? "\<c-y>\<cr>" : "\<cr>"

imap <silent> <c-u>      <plug>(coc-snippets-expand)

nmap <silent> <leader>ld <plug>(coc-definition)zv
nmap <silent> <leader>lr <plug>(coc-references)
nmap <silent> <leader>lt <plug>(coc-type-definition)
nmap <silent> <leader>li <plug>(coc-implementation)

nmap <silent> <leader>lp <plug>(coc-diagnostic-prev)
nmap <silent> <leader>ln <plug>(coc-diagnostic-next)
nmap <silent> <leader>lk :<c-u>call CocAction('doHover')<cr>

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
let g:vimtex_include_search_enabled=0

let g:vimtex_complete_enabled=0
" let g:vimtex_complete_img_use_tail = 1
" let g:vimtex_complete_bib = {
"       \ 'simple' : 1,
"       \ 'menu_fmt' : '@year, @author_short, @title',
"       \}
let g:vimtex_echo_verbose_input = 0

" vim-markdown-preview ====================================================

" let vim_markdown_preview_github=1

" tagbar ==================================================================

nmap <F8> :TagbarToggle<CR>

" vim-cool ================================================================

let g:CoolTotalMatches = 1

"==========================================================================
" vimtex Fix -- Must Be at the End of the File
"==========================================================================
if exists("g:loaded_fix_indentkeys")
    finish
endif

let g:loaded_fix_indentkeys = 1

" " Set indentkeys option again on changed filetype option.
" " This fixes TeX \item indentation in combination with YouCompleteMe.
" " See https://github.com/Valloric/YouCompleteMe/issues/1244
" " You may add more filetypes if necessary.
" autocmd FileType tex,plaintex execute "setlocal indentkeys=" . &indentkeys
