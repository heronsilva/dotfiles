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
    end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
})

-- If syntax highlighting works, auto-session might be restoring the session incorrectly.
-- Reset Treesitter and LSP when a session loads:
vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local is_single_file = vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 0
        if not is_single_file then
            vim.cmd("Neotree show last")
        end

        vim.defer_fn(function()
            vim.cmd("doautocmd BufRead")
            vim.cmd("syntax enable")
            vim.cmd("silent! edit")
        end, 100) -- Delay by 100ms to let Neo-tree fully open
    end,
})

-- Remember files last cursor position
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
vim.api.nvim_create_autocmd("BufRead", {
    callback = function(opts)
        vim.api.nvim_create_autocmd("BufWinEnter", {
            once = true,
            buffer = opts.buf,
            callback = function()
                local ft = vim.bo[opts.buf].filetype
                local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
                if
                    not (ft:match("commit") and ft:match("rebase"))
                    and last_known_line > 1
                    and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
                then
                    vim.api.nvim_feedkeys([[g`"]], "nx", false)
                end
            end,
        })
    end,
})
