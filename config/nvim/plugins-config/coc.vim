" coc config
let g:coc_global_extensions = [
\ 'coc-actions',
\ 'coc-pairs',
\ 'coc-highlight',
\ 'coc-diagnostic',
\ 'coc-import-cost',
\ 'coc-git',
\ 'coc-gitignore',
\ 'coc-terminal',
\ 'coc-swagger',
\ 'coc-vimlsp',
\ 'coc-coverage',
\ 'coc-tsserver',
\ 'coc-vetur',
\ 'coc-jest',
\ 'coc-json',
\ 'coc-format-json',
\ 'coc-python',
\ 'coc-pydocstring',
\ 'coc-yaml',
\ 'coc-css',
\ 'coc-go',
\ 'coc-rust-analyzer',
\ 'coc-sql',
\ 'coc-sqlfluff',
\ 'coc-cmake',
\ 'coc-tabnine',
\ ]
" \ 'coc-kite',
" \ 'coc-fzf-preview',

""" Remap keys for gotos
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

""""" Use K for show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if &filetype == 'vim'
      execute 'h '.expand('<cword>')
    else
      call CocAction('doHover')
    endif
endfunction

inoremap <silent><expr> <C-Space> coc#refresh()
