return {
    enabled = false,

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
}
