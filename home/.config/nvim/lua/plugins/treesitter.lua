return {
    {
        "nvim-treesitter/nvim-treesitter",
        main = "nvim-treesitter.configs",
        build = ":TSUpdate",

        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },

        -- From LazyVim
        lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
        event = { "VeryLazy" },
        opts_extend = { "ensure_installed" },
        ---@type TSConfig
        opts = {
            -- highlight = { enable = true },
            -- indent = { enable = true },
            ensure_installed = {
                "bash",
                "c",
                "diff",
                "dockerfile",
                "html",
                "javascript",
                "json",
                "jsonc",
                "lua",
                "luadoc",
                "luap",
                "markdown",
                "markdown_inline",
                "python",
                "query",
                "regex",
                "sql",
                "toml",
                "typescript",
                "vim",
                "vimdoc",
                "yaml",
            },
            textobjects = {
                move = {
                    enable = true,
                    goto_next_start = {
                        ["]f"] = "@function.outer",
                        ["]c"] = "@class.outer",
                        ["]a"] = "@parameter.inner",
                    },
                    goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
                    goto_previous_start = {
                        ["[f"] = "@function.outer",
                        ["[c"] = "@class.outer",
                        ["[a"] = "@parameter.inner",
                    },
                    goto_previous_end = {
                        ["[F"] = "@function.outer",
                        ["[C"] = "@class.outer",
                        ["[A"] = "@parameter.inner",
                    },
                },
            },

            auto_install = true,
            sync_install = false,
            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = true,
            },
            indent = { enable = true },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },

            -- autotag = { enable = true },
            -- ignore_install = {},
            -- modules = {},
        },

        ---@param opts TSConfig
        config = function(_, opts)
            require("nvim-treesitter.configs").setup(opts)
            require("nvim-treesitter.configs").setup({ textobjects = opts.textobjects })

            -- When in diff mode, we want to use the default
            -- vim text objects c & C instead of the treesitter ones.
            local move = require("nvim-treesitter.textobjects.move") ---@type table<string,fun(...)>
            local configs = require("nvim-treesitter.configs")
            for name, fn in pairs(move) do
                if name:find("goto") == 1 then
                    move[name] = function(q, ...)
                        if vim.wo.diff then
                            local config = configs.get_module("textobjects.move")[name] ---@type table<string,string>
                            for key, query in pairs(config or {}) do
                                if q == query and key:find("[%]%[][cC]") then
                                    vim.cmd("normal! " .. key)
                                    return
                                end
                            end
                        end
                        return fn(q, ...)
                    end
                end
            end
        end,

        -- There are additional nvim-treesitter modules that you can use to interact
        -- with nvim-treesitter. You should go explore a few and see what interests you:
        --
        --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
        --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
        --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        event = { "BufReadPost", "BufWritePost", "BufNewFile" },
        opts = function()
            local ts_context = require("treesitter-context")
            Snacks.toggle({
                name = "Treesitter Context",
                get = ts_context.enabled,
                set = function(state)
                    if state then
                        ts_context.enable()
                    else
                        ts_context.disable()
                    end
                end,
            }):map("<leader>ut")
            return {
                mode = "cursor",
                max_lines = 3,
            }
        end,
    },
}
