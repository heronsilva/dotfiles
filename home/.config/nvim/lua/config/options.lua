vim.g.mapleader = ";"

vim.opt.cul = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.linebreak
vim.opt.showbreak = "+++"
-- vim.opt.textwidth=100
-- vim.opt.nowrap
-- vim.opt.formatoptions=
vim.opt.showmatch = true
vim.opt.virtualedit = "block"

vim.opt.hlsearch = true
vim.opt.smartcase = true
vim.opt.ignorecase = true
vim.opt.incsearch = true

vim.opt.autoindent = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 2
vim.opt.ruler = true
vim.opt.tabstop = 2

vim.opt.undolevels = 1000
vim.opt.backspace = "indent,eol,start"
-- Enable system clipboard integration. See: https://stackoverflow.com/a/27928635
vim.opt.clipboard = unnamed

-- recommended settings from http://vim.wikia.com/wiki/Example_vimrc
-- vim.opt.nocompatible = true
vim.opt.wildmenu = true
-- vim.opt.nomodeline = true
-- vim.opt.nostartofline = true
vim.opt.confirm = true
vim.opt.mouse = "a"

-- From set.lua
vim.opt.guicursor = ""
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

vim.opt.colorcolumn = "80"
