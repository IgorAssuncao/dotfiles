if &filetype == 'terraform'
  au BufWrite *.tf :TerraformFmt
endif
