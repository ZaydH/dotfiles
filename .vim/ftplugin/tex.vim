" TeX only plugins
Plugin 'reedes/vim-wordy'

" this is mostly a matter of taste. but LaTeX looks good with just a bit
" of indentation.  Use only two spaces instead of default of four.
set tabstop=2
set shiftwidth=2
" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

" Remap the commands in LaTeX so the cursor respects wrap around
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>

" Based on comment:
" https://github.com/lervag/vimtex/issues/168#issuecomment-108019496
let g:tex_fast = "bMpr"
let g:tex_conceal = ""

" Settings needed to speed up latex
set nocursorline
set nornu
set number
let g:loaded_matchparen=1
