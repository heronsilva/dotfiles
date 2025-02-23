vim.g.mapleader = ";"
vim.g.maplocalleader = ";"

vim.g.have_nerd_font = true

vim.opt.cul = true
vim.opt.number = true
vim.opt.relativenumber = true
-- vim.opt.linebreak
-- Enable break indent
vim.opt.breakindent = true
vim.opt.showbreak = "+++"
-- vim.opt.textwidth=100
-- vim.opt.nowrap
-- vim.opt.formatoptions=
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

-- Enable system clipboard integration. See: https://stackoverflow.com/a/27928635
-- vim.opt.clipboard = unnamed

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
-- vim.schedule(function()
vim.opt.clipboard = "unnamedplus"
-- end)

-- recommended settings from http://vim.wikia.com/wiki/Example_vimrc
-- vim.opt.nocompatible = true
vim.opt.wildmenu = true
-- vim.opt.nomodeline = true
-- vim.opt.nostartofline = true
vim.opt.confirm = true
vim.opt.mouse = "a"

-- Show which line your cursor is on
vim.opt.cursorline = true

-- From set.lua
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
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.colorcolumn = "120"

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
-- vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
vim.opt.listchars = {
    space = "⋅",
    trail = "⋅",
    -- eol = "↲",
    tab = "» ",
    nbsp = "␣",
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = "split"

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- Code folding settings for treesitter and ufo plugins
vim.o.foldcolumn = "1"
vim.opt.foldenable = true
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.g.markdown_folding = 1

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"

-- Enable break indent
vim.o.breakindent = true
