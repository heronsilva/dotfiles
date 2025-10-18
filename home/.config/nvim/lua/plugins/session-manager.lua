return {
    "Shatur/neovim-session-manager",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function(_, opts)
        local session_manager = require("session_manager")
        local config = require("session_manager.config")

        require("session_manager").setup(vim.tbl_deep_extend("force", opts, {
            autoload_mode = { config.AutoloadMode.CurrentDir },
            autosave_last_session = true,
            load_include_current = true,
        }))

        -- Save the current session
        vim.keymap.set("n", "<leader>qs", function()
            session_manager.save_current_session()
            vim.notify("Session saved! 🎯")
        end, { noremap = true, silent = true, desc = "Save session" })

        -- Load the last session
        vim.keymap.set("n", "<leader>ql", function()
            session_manager.load_last_session()
        end, { noremap = true, silent = true, desc = "Load last session" })

        -- Delete the current session
        vim.keymap.set("n", "<leader>qd", function()
            session_manager.delete_session()
        end, { noremap = true, silent = true, desc = "Delete session" })

        -- Browse and load a session using Telescope
        vim.keymap.set("n", "<leader>qb", function()
            require("session_manager").load_session(false)
        end, { noremap = true, silent = true, desc = "Browse sessions" })

        -- Auto save session
        vim.api.nvim_create_autocmd({ "BufWritePre" }, {
            callback = function()
                for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                    -- Don't save while there's any 'nofile' buffer open.
                    if vim.api.nvim_get_option_value("buftype", { buf = buf }) == "nofile" then
                        return
                    end
                end
                session_manager.save_current_session()
            end,
        })

        -- https://github.com/Shatur/neovim-session-manager?tab=readme-ov-file#autocommands
        local config_group = vim.api.nvim_create_augroup("MyConfigGroup", {}) -- A global group for all your config autocommands
        vim.api.nvim_create_autocmd({ "User" }, {
            pattern = "SessionLoadPost",
            group = config_group,
            callback = function()
                require("neo-tree.command").execute({
                    show = true,
                    toggle = false,
                })
            end,
        })
    end,
}
