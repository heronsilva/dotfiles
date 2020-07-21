call plug#begin('~/.vim/plugged')
Plug 'mattn/emmet-vim'
call plug#end()

syntax on
colorscheme nord
filetype plugin indent on

set cul                 " Enable current line
set number              " Show line numbers
set linebreak           " Break lines at word (requires Wrap lines)
set showbreak=+++       " Wrap-broken line prefix
set textwidth=100       " Line wrap (number of cols)
set showmatch           " Highlight matching brace
set virtualedit=block   " Enable free-range cursor

set hlsearch            " Highlight all search results
set smartcase           " Enable smart-case search
set ignorecase          " Always case-insensitive
set incsearch           " Searches for strings incrementally

set autoindent          " Auto-indent new lines
set expandtab           " Use spaces instead of tabs
set shiftwidth=2        " Number of auto-indent spaces
set smartindent         " Enable smart-indent
set smarttab            " Enable smart-tabs
set softtabstop=2       " Number of spaces per Tab
set ruler               " Show row and column ruler information
set tabstop=2

set undolevels=1000             " Number of undo levels
set backspace=indent,eol,start  " Backspace behaviour
set clipboard=unnamedplus       " Enable system clipboard integration

" recommended settings from http://vim.wikia.com/wiki/Example_vimrc
set nocompatible
set wildmenu
set nomodeline
set nostartofline
set confirm
set mouse=a

" nerdtree settings
" auto start plugin when starting vim opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" Emmet
let g:user_emmet_leader_key=',' " Redefine default emmet trigger key: https://github.com/mattn/emmet-vim#redefine-trigger-key
