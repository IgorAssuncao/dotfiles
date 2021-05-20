let g:NERDTreeShowHidded=1

function! NerdTreeToggle()
   :NERDTreeToggle
   if g:NERDTree.IsOpen()
     set number relativenumber
   endif
endfunc
nnoremap <leader>t :call NerdTreeToggle() <CR>
