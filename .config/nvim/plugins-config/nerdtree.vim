let g:NERDTreeShowHidden=1

function! NerdTreeToggle()
   :NERDTreeToggle
   if g:NERDTree.IsOpen()
     set number relativenumber
   endif
endfunc
nnoremap <silent> <leader>t :call NerdTreeToggle() <CR>
