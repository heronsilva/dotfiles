return {
    -- Mason core: installs language servers and tools
    {
        "williamboman/mason.nvim",
        config = true,
    },

    -- Automatically install LSP servers
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = { "williamboman/mason.nvim" },
        opts = {
            ensure_installed = {
                "lua_ls",
                "ts_ls",
                "pyright",
                "bashls",
                "gopls",
                "sqls",
                "clangd",
            },
            automatic_installation = true,
        },
    },

    -- 🔧 Automatically install formatters / linters
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            require("mason-tool-installer").setup({
                ensure_installed = {
                    -- LSP servers (redundant but harmless)
                    "lua-language-server",
                    "typescript-language-server",
                    "pyright",
                    "bash-language-server",
                    "gopls",
                    "sqls",
                    "clangd",

                    -- JS / TS
                    -- "eslint_d",
                    "eslint-lsp",
                    "prettierd",

                    -- Python
                    "black",
                    "isort",

                    -- Shell
                    -- "shellcheck",
                    "shfmt",

                    -- Go
                    "gofumpt",

                    -- Lua
                    "stylua",

                    -- SQL
                    "sqlfmt",

                    -- C / C++
                    "clang-format",
                },
                auto_update = false,
                run_on_start = true,
            })
        end,
    },

    -- 🌐 LSP Config
    {
        "neovim/nvim-lspconfig",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local telescope_builtin = require("telescope.builtin")

            -- Capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            local ok_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
            if ok_cmp then
                capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
            end

            -- Keymaps on attach
            local on_attach = function(_, bufnr)
                local function map(keys, func, desc, modes)
                    modes = modes or "n"
                    vim.keymap.set(modes, keys, func, { buffer = bufnr, silent = true, desc = desc })
                end

                -- 🚀 Your original mappings
                map("gd", telescope_builtin.lsp_definitions, "[G]oto [D]efinition")
                map("gr", telescope_builtin.lsp_references, "[G]oto [R]eferences")
                map("gI", telescope_builtin.lsp_implementations, "[G]oto [I]mplementation")
                map("<leader>D", telescope_builtin.lsp_type_definitions, "Type [D]efinition")
                map("<leader>ds", telescope_builtin.lsp_document_symbols, "[D]ocument [S]ymbols")
                map("<leader>ws", telescope_builtin.lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")
                map("<leader>rn", vim.lsp.buf.rename, "[R]e[n]ame")
                map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction", { "n", "x" })
                map("gD", vim.lsp.buf.declaration, "[G]oto [D]eclaration")
            end

            local defaults = {
                capabilities = capabilities,
                on_attach = on_attach,
            }

            -- Language servers
            local servers = {
                lua_ls = {
                    settings = {
                        Lua = {
                            runtime = { version = "LuaJIT" },
                            diagnostics = { globals = { "vim" } },
                            workspace = { checkThirdParty = false },
                            telemetry = { enable = false },
                        },
                    },
                },
                ts_ls = {},
                pyright = {},
                bashls = {},
                gopls = {},
                sqls = {},
                clangd = {},
            }

            -- Apply configs
            for server, config in pairs(servers) do
                vim.lsp.config(server, vim.tbl_deep_extend("force", defaults, config))
                vim.lsp.enable(server)
            end

            -- Format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                callback = function(args)
                    vim.lsp.buf.format({ bufnr = args.buf, timeout_ms = 3000 })
                end,
            })
        end,
    },

    -- 🧠 Completion
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "hrsh7th/cmp-cmdline",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                mapping = cmp.mapping.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp" },
                    { name = "buffer" },
                    { name = "path" },
                }),
            })
        end,
    },

    -- 🧹 Linters & Formatters
    {
        "nvimtools/none-ls.nvim",
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            local null_ls = require("null-ls")
            local builtins = null_ls.builtins

            null_ls.setup({
                sources = {
                    -- JS / TS
                    builtins.formatting.prettierd,
                    -- builtins.diagnostics.eslint_d,
                    -- builtins.code_actions.eslint_d,

                    -- Python
                    builtins.formatting.black,
                    builtins.formatting.isort,

                    -- Shell
                    -- builtins.diagnostics.shellcheck,
                    builtins.formatting.shfmt,

                    -- Go
                    builtins.formatting.gofumpt,

                    -- Lua
                    builtins.formatting.stylua,

                    -- SQL
                    builtins.formatting.sqlfmt,

                    -- C / C++
                    builtins.formatting.clang_format,
                },
                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_clear_autocmds({ group = "LspFormatting", buffer = bufnr })
                        vim.api.nvim_create_autocmd("BufWritePre", {
                            group = vim.api.nvim_create_augroup("LspFormatting", {}),
                            buffer = bufnr,
                            callback = function()
                                vim.lsp.buf.format({ bufnr = bufnr })
                            end,
                        })
                    end
                end,
            })
        end,
    },
}
