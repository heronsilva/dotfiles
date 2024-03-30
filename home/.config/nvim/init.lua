-- https://github.com/garcia5/dotfiles/blob/master/files/nvim/init.lua

require("config.options")

if vim.loader then
  vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)
end

require("config.lazy")
require("config.keymaps")

vim.cmd("colorscheme gruvbox")
