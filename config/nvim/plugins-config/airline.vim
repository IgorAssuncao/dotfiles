" airline config
" let g:airline_statusline_ontop = 0
let g:airline_theme = 'angr'

" airline extensions
let g:airline_extensios = ['branch', 'coc']
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#formatter = 'unique_tail'
