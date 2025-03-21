if vim.loader then
    vim.loader.enable() -- cache lua modules (https://github.com/neovim/neovim/pull/22668)
end

require("config.options")
require("config.lazy")
require("config.autocmds")
require("config.keymaps")
require("config.colors")
require("config.session")
