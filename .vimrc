
" n: normal only
" v: visual and select
" o: operator-pending
" x: visual only
" s: select only
" i: insert
" c: command-line
" l: insert, command-line, regexp-search (and others. Collectively called "Lang-Arg" pseudo-mode)

let mapleader = ';'

call plug#begin('~/.vim/plugged')

Plug 'editorconfig/editorconfig-vim'
Plug 'romainl/vim-cool' " https://vi.stackexchange.com/a/13378
Plug 'habamax/vim-gruvbit'
Plug 'easymotion/vim-easymotion'
Plug 'arcticicestudio/nord-vim'

call plug#end()

syntax on
filetype plugin indent on

set cul                 " Enable current line
set number              " Show line numbers
" set linebreak           " Break lines at word (requires Wrap lines)
set showbreak=+++       " Wrap-broken line prefix
" set textwidth=100       " Line wrap (number of cols)
" set nowrap              " Do not automatically wrap on load
" set formatoptions=      " Do not automatically wrap text when typing
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
set clipboard=unnamedplus       " Enable system clipboard integration. See: https://stackoverflow.com/a/27928635

" recommended settings from http://vim.wikia.com/wiki/Example_vimrc
set nocompatible
set wildmenu
set nomodeline
set nostartofline
set confirm
set mouse=a

" nerdtree settings
" auto start plugin when starting vim opening a directory
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

" search for visually selected text. see: https://vim.fandom.com/wiki/Search_for_visually_selected_text
vnoremap // y/\V<C-R>=escape(@",'/\')<CR><CR>

" delete sends text to 'black hole' instead of clipboard: https://stackoverflow.com/q/54255,
nnoremap d "_d
nnoremap x "_x
nnoremap dd "_dd
vnoremap d "_d
" vnoremap x "_x

" save current file
nnoremap <leader>w :w<CR>
inoremap <leader>w <Esc>:w<CR>
nnoremap <leader>q :q<CR>

" select all text
nnoremap <C-A> ggVG

xnoremap "+y y:call system("wl-copy", @")<cr>
nnoremap "+p :let @"=substitute(system("wl-paste --no-newline"), '<C-v><C-m>', '', 'g')<cr>p
nnoremap "*p :let @"=substitute(system("wl-paste --no-newline --primary"), '<C-v><C-m>', '', 'g')<cr>p

" BEGIN vim-easymotion
map <Leader> <Plug>(easymotion-prefix)
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap s <Plug>(easymotion-overwin-f)
" or
" `s{char}{char}{label}`
" Need one more keystroke, but on average, it may be more comfortable.
nmap s <Plug>(easymotion-overwin-f2)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)
" END vim-easymotion

" Get current direcory in command mode
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

