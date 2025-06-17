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
        -- if vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
        --     vim.cmd("cd " .. vim.fn.argv(0)) -- Set working directory
        --     vim.cmd("enew") -- Open a new empty buffer
        --     vim.cmd("bwipeout " .. vim.fn.bufnr(1)) -- Remove the directory buffer
        -- end

        -- If only an empty buffer (`[No Name]`) is left, remove it
        -- if vim.fn.bufname() == "" and vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
        --     vim.cmd("bwipeout")
        -- end
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
-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         local is_single_file = vim.fn.argc() == 1 and vim.fn.isdirectory(vim.fn.argv(0)) == 0
--         if not is_single_file then
--             vim.cmd("Neotree show last")
--         end
--
--         vim.defer_fn(function()
--             vim.cmd("doautocmd BufRead")
--             vim.cmd("syntax enable")
--             vim.cmd("silent! edit")
--         end, 100) -- Delay by 100ms to let Neo-tree fully open
--     end,
-- })

-- Remember files last cursor position
-- https://github.com/neovim/neovim/issues/16339#issuecomment-1457394370
-- vim.api.nvim_create_autocmd("BufRead", {
--     callback = function(opts)
--         vim.api.nvim_create_autocmd("BufWinEnter", {
--             once = true,
--             buffer = opts.buf,
--             callback = function()
--                 local ft = vim.bo[opts.buf].filetype
--                 local last_known_line = vim.api.nvim_buf_get_mark(opts.buf, '"')[1]
--                 if
--                     not (ft:match("commit") and ft:match("rebase"))
--                     and last_known_line > 1
--                     and last_known_line <= vim.api.nvim_buf_line_count(opts.buf)
--                 then
--                     vim.api.nvim_feedkeys([[g`"]], "nx", false)
--                 end
--             end,
--         })
--     end,
-- })

-- vim.api.nvim_create_user_command("CopyBufferAbsolutePath", function()
--     local full_path = vim.fn.expand("%:p")
--
--     -- Copy to clipboard
--     vim.fn.setreg("+", full_path)
--
--     vim.notify('Copied "' .. full_path .. '" to the clipboard!')
-- end, {
--     desc = "Copy absolute path of active buffer",
-- })
--
-- vim.api.nvim_create_user_command("CopyBufferRelativePath", function()
--     local full_path = vim.fn.expand("%:p") -- Get full file path
--     local project_root = Heron.ROOT -- Get current working directory
--     local relative_path = full_path:gsub("^" .. vim.pesc(project_root .. "/"), "") -- Remove project root prefix
--
--     -- Copy to clipboard
--     vim.fn.setreg("+", relative_path)
--
--     vim.notify(relative_path)
-- end, {
--     desc = "Copy relative path of active buffer",
-- })

-- vim.api.nvim_create_autocmd("VimLeavePre", {
--     callback = function()
--         require("session_manager").save_current_session()
--     end,
-- })

-- vim.api.nvim_create_autocmd("VimEnter", {
--     callback = function()
--         -- if vim.fn.argc() == 0 then -- Only restore session if no file was opened
--         require("session_manager").load_current_dir_session()
--         vim.notify("xablau")
--         -- end
--     end,
--     desc = "Auto restore session for current project root",
-- })

-- vim.api.nvim_create_autocmd("User", {
--     pattern = "SessionLoadPost",
--     callback = function()
--         local neo_tree_was_open = vim.fn.exists("#NeoTree") == 1
--         if neo_tree_was_open and vim.fn.argc() == 0 then
--             require("neo-tree.command").execute({ toggle = true })
--         end
--     end,
-- })
