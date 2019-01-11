" Preserve trailing whitespace since this is used to create linebreaks
" See: https://gist.github.com/shaunlebron/746476e6e7a4d698b373
:autocmd! BufWritePre

" Remap the commands in LaTeX so the cursor respects wrap around
noremap  <buffer> <silent> <Up>   gk
noremap  <buffer> <silent> <Down> gj
noremap  <buffer> <silent> <Home> g<Home>
noremap  <buffer> <silent> <End>  g<End>
inoremap <buffer> <silent> <Up>   <C-o>gk
inoremap <buffer> <silent> <Down> <C-o>gj
inoremap <buffer> <silent> <Home> <C-o>g<Home>
inoremap <buffer> <silent> <End>  <C-o>g<End>
