function! SourceFileIfExists(filename)
  let l:extra_file = fnamemodify($HOME, ':p:h') . '/system-config/config/nvim/' . a:filename .'.vim'
  if filereadable(l:extra_file)
    execute ':so ' . l:extra_file
  else
    echo 'Could not load ' . a:filename
  endif
  unlet l:extra_file
endfunc

""" Source files
" General
call SourceFileIfExists('general/settings')

" Mappings
call SourceFileIfExists('general/mappings')

" Filetypes customization
call SourceFileIfExists('general/filetypes/terraform')

" VimPlug Init
call SourceFileIfExists('vim-plug/plugins')

" Plugins configs
call SourceFileIfExists('plugins-config/airline')
call SourceFileIfExists('plugins-config/nerdtree')
call SourceFileIfExists('plugins-config/fugitive')
call SourceFileIfExists('plugins-config/coc')

" Themes
" call SourceFileIfExists('themes/one')
call SourceFileIfExists('themes/onedark')
" call SourceFileIfExists('themes/jummidark')
" call SourceFileIfExists('themes/tokyonight')

" Custom themes (located in colors dir)
" call SourceFileIfExists('colors/lucid')
