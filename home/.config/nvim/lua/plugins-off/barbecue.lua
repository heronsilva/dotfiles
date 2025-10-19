return {
    enabled = false,

    "utilyre/barbecue.nvim",
    name = "barbecue",
    version = "*",
    dependencies = {
        "SmiteshP/nvim-navic",
        "nvim-tree/nvim-web-devicons", -- optional dependency
    },
    opts = {},
    config = function()
        require("barbecue").setup(
            --- @type barbecue.Config
            {
                create_autocmd = false, -- prevent barbecue from updating itself automatically
                show_basename = false,
                show_dirname = false,
                show_navic = true,
            }
        )

        -- Gain better performance when moving the cursor around
        -- triggers CursorHold event faster
        vim.opt.updatetime = 200

        vim.api.nvim_create_autocmd({
            "WinScrolled",
            "BufWinEnter",
            "CursorHold",
            "InsertLeave",

            -- include this if you have set `show_modified` to `true`
            "BufModifiedSet",
        }, {
            group = vim.api.nvim_create_augroup("barbecue.updater", {}),
            callback = function()
                require("barbecue.ui").update()
            end,
        })
    end,
}
