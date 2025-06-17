return {
    enabled = false,

    "mrjones2014/legendary.nvim",
    dependencies = { "kkharji/sqlite.lua" }, -- Optional, for persistence
    event = "VeryLazy",
    config = function()
        require("legendary").setup({
            -- 🔥 Enable fuzzy search for commands + keymaps
            -- lazy_nvim = { auto_register = true }, -- Works with LazyVim

            -- 🏆 Register Which-Key mappings automatically (New syntax)
            extensions = {
                lazy_nvim = true,
                which_key = {
                    -- Automatically add which-key tables to legendary
                    -- see WHICH_KEY.md for more details
                    auto_register = true,
                    -- you can put which-key.nvim tables here,
                    -- or alternatively have them auto-register,
                    -- see WHICH_KEY.md
                    mappings = {},
                    opts = {},
                    -- controls whether legendary.nvim actually binds they keymaps,
                    -- or if you want to let which-key.nvim handle the bindings.
                    -- if not passed, true by default
                    do_binding = true,
                    -- controls whether to use legendary.nvim item groups
                    -- matching your which-key.nvim groups; if false, all keymaps
                    -- are added at toplevel instead of in a group.
                    use_groups = true,
                },
            },

            -- 🌟 UI Enhancements
            select_prompt = "🔍 Search Commands & Keymaps...",
            most_recent_items = {
                enable = true, -- Show recent items
                include_commands = true,
                include_keymaps = true,
            },

            -- 🎯 Keymaps + Commands (Custom)
            commands = {
                -- { ":Lazy", description = "Open Lazy package manager" },
                -- { ":Mason", description = "Manage LSP, linters, and formatters" },
                {
                    ":CopyBufferAbsolutePath",
                    function()
                        local full_path = vim.fn.expand("%:p")

                        -- Copy to clipboard
                        vim.fn.setreg("+", full_path)

                        vim.notify('Copied "' .. full_path .. '" to the clipboard!')
                    end,
                    description = "Copy absolute path of active buffer",
                },
                {
                    ":CopyBufferRelativePath",
                    function()
                        local full_path = vim.fn.expand("%:p") -- Get full file path
                        local project_root = Heron.ROOT -- Get current working directory
                        local relative_path = full_path:gsub("^" .. vim.pesc(project_root .. "/"), "") -- Remove project root prefix

                        -- Copy to clipboard
                        vim.fn.setreg("+", relative_path)

                        vim.notify(relative_path)
                    end,
                    desc = "Copy relative path of active buffer",
                },
            },
        })

        -- 🏷 Set a keybinding to open it quickly
        vim.keymap.set({ "n", "x" }, "<leader>cp", "<cmd>Legendary<CR>", { noremap = true, silent = true })
        vim.keymap.set("n", "<D-S-P>", "<cmd>Legendary<CR>", { noremap = true, silent = true })
    end,
}
