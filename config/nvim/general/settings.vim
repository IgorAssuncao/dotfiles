syntax enable
filetype plugin indent on
set number relativenumber
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set number relativenumber
  autocmd BufLeave,FocusLost,InsertEnter * set number norelativenumber
augroup END
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
" set colorcolumn=80,120
" let &colorcolumn="80,".join(range(120,999),",")
" highlight ColorColumn ctermbg=0 guibg=NONE
highlight Normal guibg=NONE ctermbg=NONE
set nowrap
set noswapfile
set nowritebackup
set nobackup
set incsearch

" Choose which autocomplete plugin VIM will use.
set omnifunc=syntaxcomplete#Complete " coc
" set omnifunc=ale#completion#OmniFunc " ale

" Disables automatic commenting on new line
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o

" Splits open at the bottom and right
set splitbelow splitright

set background=dark
if (has("termguicolors"))
  set termguicolors
endif
