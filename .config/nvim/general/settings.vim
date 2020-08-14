syntax enable
syntax on
filetype plugin indent on
set number relativenumber
set numberwidth=2
set breakindent
set autoindent
set smartindent
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set ruler
set cursorline
set colorcolumn=80,120
highlight ColorColumn ctermbg=0 guibg=lightgrey
let &colorcolumn="80,".join(range(120,999),",")
set nowrap
set noswapfile
set nowritebackup
set nobackup
set incsearch
set omnifunc=syntaxcomplete#Complete
" set omnifunc=ale#completion#OmniFunc

set background=dark
if (has("termguicolors"))
  set termguicolors
endif
