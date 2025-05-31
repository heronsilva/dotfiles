-- if vim.loader then
--     vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)
-- end

require("config.options")
require("config.lazy")
-- require("config.autocmds")
require("config.keymaps")
require("config.colors")
-- require("config.session")

-- vim.cmd("colorscheme catppuccin-frappe")
vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
