vim.opt.cul = true
vim.opt.number = true
vim.opt.linebreak = true
vim.opt.showbreak = "+++"
vim.opt.showmatch = true
vim.opt.virtualedit = "block"

vim.opt.hlsearch = false
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
vim.opt.clipboard = "unnamedplus"

-- recommended settings from http://vim.wikia.com/wiki/Example_vimrc
vim.opt.wildmenu = true
vim.opt.confirm = true
vim.opt.mouse = "a"

--
-- from theprimeagen
--
vim.opt.guicursor = ""
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true
vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")
vim.opt.updatetime = 50
vim.opt.colorcolumn = "80"

