" coc config
let g:coc_global_extensions = [
\ 'coc-pairs',
\ 'coc-tsserver',
\ 'coc-json',
\ 'coc-vetur',
\ 'coc-python',
\ 'coc-yaml',
\ ]

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
