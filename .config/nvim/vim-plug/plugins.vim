let vimPlugDir = fnamemodify($HOME, ':p:h') . '/system-config/.config/nvim/autoload'

"""""" VimPlug
if empty(glob(vimPlugDir . '/plug.vim'))
  silent !curl -fLo $HOME/system-config/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

autocmd VimEnter *
  \   if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|    PlugInstall --sync | q
  \|  endif

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin(vimPlugDir . '/plugged')

" Make sure you use single quotes

" Any valid git URL is allowed

"""""" Directory management and travel
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

"""""" Syntax highlighting
Plug 'sheerun/vim-polyglot'

"""""" Linting and Completion
Plug 'w0rp/ale'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

"""""" Vim read .editorconfig file
Plug 'editorconfig/editorconfig-vim'

"""""" Allow multiple cursors on vim
" Plug 'terryma/vim-multiple-cursors'

"""""" Auto insert quotes, parentheses, brackets, braces
Plug 'jiangmiao/auto-pairs'

"""""" Themes
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

"""""" Syntax highlighting js
" Plug 'pangloss/vim-javascript'
" Plug 'mxw/vim-jsx'

call plug#end()

unlet vimPlugDir
