-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("autoupdate"),
    callback = function()
        if require("lazy.status").has_updates then
            require("lazy").update({
                show = false,
                concurrency = 10,
            })
        end

        -- If Neovim was opened with exactly one argument AND it's a directory
        if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
            vim.cmd("cd " .. vim.fn.argv(0)) -- Set working directory
            vim.cmd("enew") -- Open a new empty buffer
            vim.cmd("bwipeout " .. vim.fn.bufnr(1)) -- Remove the directory buffer
        end

        -- If only an empty buffer (`[No Name]`) is left, remove it
        if vim.fn.bufname() == "" and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
            vim.cmd("bwipeout")
        end
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})
