return {
    enabled = false,

    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
        "folke/noice.nvim",
    },
    config = function()
        require("lualine").setup({
            options = {
                icons_enabled = true,
                theme = "auto",
                component_separators = { left = "", right = "" },
                section_separators = { left = "", right = "" },
                disabled_filetypes = {
                    statusline = {},
                    winbar = {},
                },
                ignore_focus = {},
                always_divide_middle = true,
                always_show_tabline = true,
                globalstatus = false,
                refresh = {
                    statusline = 100,
                    tabline = 100,
                    winbar = 100,
                },
            },
            sections = {
                lualine_a = { "mode" },
                lualine_b = { "branch", "diff", "diagnostics" },
                -- lualine_c = { "filename" },
                lualine_x = { "encoding", "fileformat", "filetype" },
                lualine_y = { "progress" },
                lualine_z = { "location" },
            },
            -- inactive_sections = {
            --     lualine_a = {},
            --     lualine_b = {},
            --     lualine_c = { "filename" },
            --     lualine_x = { "location" },
            --     lualine_y = {},
            --     lualine_z = {},
            -- },
            -- tabline = {
            --     lualine_a = { "buffers" },
            --     lualine_b = { "branch" },
            --     lualine_c = { "filename" },
            --     lualine_x = {},
            --     lualine_y = {},
            --     lualine_z = { "tabs" },
            -- },
            winbar = {},
            inactive_winbar = {},
            extensions = {},
            -- sections = {
            --     lualine_x = {
            --         {
            --             require("noice").api.statusline.mode.get,
            --             cond = require("noice").api.statusline.mode.has,
            --             color = { fg = "#ff9e64" },
            --         },
            --         {
            --             require("noice").api.status.command.get,
            --             cond = require("noice").api.status.command.has,
            --             color = { fg = "#ff9e64" },
            --         },
            --     },
            -- lualine_a = {
            --     {
            --         "buffers",
            --     },
            -- },
            -- },
        })
    end,
}
