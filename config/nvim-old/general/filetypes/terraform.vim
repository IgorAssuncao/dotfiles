" if &filetype == 'terraform'
"   au BufWrite *.tf :TerraformFmt
" endif

" au BufWritePre *.tf if &filetype == 'terraform' | :TerraformFmt | endif
au BufWritePre *.tf :TerraformFmt
