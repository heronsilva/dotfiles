return { -- https://github.com/ThePrimeagen/refactoring.nvim
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    config = function()
        require("refactoring").setup()

        vim.keymap.set("x", "<leader>re", function()
            require("refactoring").refactor("Extract Function")
        end, { desc = "Refactor: Extract function" })

        -- Extract function supports only visual mode
        vim.keymap.set("x", "<leader>rf", function()
            require("refactoring").refactor("Extract Function To File")
        end, { desc = "Refactor: Extract Function To File" })

        -- Extract variable supports only visual mode
        vim.keymap.set("x", "<leader>rv", function()
            require("refactoring").refactor("Extract Variable")
        end, { expr = true, desc = "Refactor: Extract variable" })

        -- Inline func supports only normal
        vim.keymap.set("n", "<leader>rI", function()
            require("refactoring").refactor("Inline Function")
        end, { desc = "Refactor: Inline function" })

        -- Inline var supports both normal and visual mode
        vim.keymap.set({ "n", "x" }, "<leader>ri", function()
            require("refactoring").refactor("Inline Variable")
        end, { desc = "Refactor: Inline variable" })

        vim.keymap.set("n", "<leader>rb", function()
            require("refactoring").refactor("Extract Block")
        end, { desc = "Refactor: Extract block" })

        -- Extract block supports only normal mode
        vim.keymap.set("n", "<leader>rbf", function()
            require("refactoring").refactor("Extract Block To File")
        end, { desc = "Refactor: Extract block to file" })
    end,
}
