local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    { import = "plugins" },
    {
        "utilyre/barbecue.nvim",
        name = "barbecue",
        version = "*",
        dependencies = {
            "SmiteshP/nvim-navic",
            "nvim-tree/nvim-web-devicons", -- optional dependency
        },
        opts = {},
    },
    {
        "github/copilot.vim",
        event = "VeryLazy",
        cmd = "Copilot", -- this makes copilot to start as disabled
        lazy = false,
        enabled = false,
        keys = {
            {
                "<M-\\>",
                ":CopilotToggle<CR>",
                mode = "n",
                desc = "Toggle Copilot",
                noremap = true,
                silent = true,
            },
        },
        config = function()
            require("copilot").setup()
            local copilot_on = true
            vim.api.nvim_create_user_command("CopilotToggle", function()
                if copilot_on then
                    vim.cmd("Copilot disable")
                    print("Copilot OFF")
                else
                    vim.cmd("Copilot enable")
                    print("Copilot ON")
                end

                copilot_on = not copilot_on
            end, { nargs = 0 })
        end,
    },
    {
        "mbbill/undotree",
        keys = {
            {
                "<leader>u",
                ":UndotreeToggle<CR>",
                mode = "n",
                desc = "Toggle Undotree",
                silent = true,
            },
        },
    },
    {
        "stevearc/dressing.nvim",
        event = "VeryLazy",
        config = function()
            require("dressing").setup()
        end,
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({
                -- Configuration here, or leave empty to use defaults
            })
        end,
    },
    { -- Adds git related signs to the gutter, as well as utilities for managing changes
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    {
        "folke/zen-mode.nvim",
        ---@module "zen-mode"
        ---@type ZenOptions
        opts = {},
    },
    { -- https://github.com/ThePrimeagen/refactoring.nvim
        "ThePrimeagen/refactoring.nvim",
        -- enabled = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        lazy = false,
        config = function()
            require("refactoring").setup()

            vim.keymap.set("x", "<leader>re", function()
                require("refactoring").refactor("Extract Function")
            end)
            vim.keymap.set("x", "<leader>rf", function()
                require("refactoring").refactor("Extract Function To File")
            end)
            -- Extract function supports only visual mode
            vim.keymap.set("x", "<leader>rv", function()
                require("refactoring").refactor("Extract Variable")
            end)
            -- Extract variable supports only visual mode
            vim.keymap.set("n", "<leader>rI", function()
                require("refactoring").refactor("Inline Function")
            end)
            -- Inline func supports only normal
            vim.keymap.set({ "n", "x" }, "<leader>ri", function()
                require("refactoring").refactor("Inline Variable")
            end)
            -- Inline var supports both normal and visual mode

            vim.keymap.set("n", "<leader>rb", function()
                require("refactoring").refactor("Extract Block")
            end)
            vim.keymap.set("n", "<leader>rbf", function()
                require("refactoring").refactor("Extract Block To File")
            end)
            -- Extract block supports only normal mode
        end,
    },
    {
        "sindrets/diffview.nvim",
        opts = {
            keymaps = {
                file_panel = {
                    { { "n" }, "g?", "<Cmd>h diffview.defaults<CR>", { desc = "Open the default config" } },
                },
            },
        },
    },
}, {
    defaults = {
        -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
        -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
        lazy = false,
        -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
        -- have outdated releases, which may break your Neovim install.
        version = false, -- always use the latest git commit
        -- version = "*", -- try installing the latest stable version for plugins that support semver
    },
    -- install = { colorscheme = { "gruvbox" } },
    checker = { enabled = true }, -- automatically check for plugin updates,
    change_detection = {
        -- automatically check for config file changes and reload the ui
        enabled = true,
        notify = false,
    },
    ui = {
        -- If you are using a Nerd Font: set icons to an empty table which will use the
        -- default lazy.nvim defined Nerd Font icons, otherwise define a unicode icons table
        icons = vim.g.have_nerd_font and {} or {
            cmd = "⌘",
            config = "🛠",
            event = "📅",
            ft = "📂",
            init = "⚙",
            keys = "🗝",
            plugin = "🔌",
            runtime = "💻",
            require = "🌙",
            source = "📄",
            start = "🚀",
            task = "📌",
            lazy = "💤 ",
        },
    },
})
