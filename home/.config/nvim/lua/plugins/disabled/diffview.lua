return {
    enabled = false,

    "sindrets/diffview.nvim",
    opts = {
        keymaps = {
            file_panel = {
                {
                    { "n" },
                    "g?",
                    "<Cmd>h diffview.defaults<CR>",
                    { desc = "Open the default config" },
                },
            },
        },
    },
    config = function(_, opts)
        require("diffview").setup(opts)

        vim.api.nvim_create_user_command("DiffviewToggle", function()
            local lib = require("diffview.lib")
            local view = lib.get_current_view()
            if view then
                -- Current tabpage is a Diffview; close it
                vim.cmd(":DiffviewClose")
            else
                -- No open Diffview exists: open a new one
                vim.cmd(":DiffviewOpen")
            end
        end, {})
    end,
}
