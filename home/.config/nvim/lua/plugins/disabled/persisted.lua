return {
    enabled = false,

    "olimorris/persisted.nvim",

    event = "BufReadPre",

    config = function()
        require("persisted").setup({
            autostart = true,
            autosave = true,
            autoload = true,

            allowed_dirs = { "~/Workbench/" },

            on_autoload_no_session = function()
                vim.notify("No existing session to load.")
            end,
        })
    end,
}
